//
//  TasksService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksService.h"

// Classes
#import "TasksAPIService.h"
#import "ProjectTaskModel.h"
#import "APIConstance.h"
#import "TasksGroupedByProjects.h"
#import "TaskAvailableActionsModel.h"
#import "ProjectInfo+CoreDataClass.h"
#import "FilledTeamInfo.h"
#import "TaskCommentsService.h"
#import "UserInfoService.h"

// Categories
#import "DataManager+Tasks.h"
#import "DataManager+TaskAvailableActions.h"
#import "DataManager+ProjectInfo.h"
#import "NSDate+Helper.h"
#import "DataManager+TaskLogs.h"

@implementation TasksService


#pragma mark - Shared -

+ (instancetype) sharedInstance
{
    static TasksService* instance = nil;

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        instance = [TasksService new];
        
    });

    return instance;
}


#pragma mark - Public methods -

- (RACSignal*) loadAllTasksForProjectWithID: (NSNumber*) projectID
{
    NSString* requestURL = [projectTasksURL stringByReplacingOccurrencesOfString: @"{id}"
                                                                      withString: projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadTasksForProjectSignal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[[TasksAPIService sharedInstance] loadTasksForProjectWithURL: requestURL]
          deliverOn: [RACScheduler mainThreadScheduler]]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseTasksForProjectFromResponse: response[0]
                                     withCompletion: ^(BOOL isSuccess) {
                                         
                                         [subscriber sendNext: nil];
                                         [subscriber sendCompleted];
                                         
                                     }];
             
         }
         error: ^(NSError* error) {
             
             [subscriber sendError: error];
         }];
        
        
        return nil;
    }];
    
    return loadTasksForProjectSignal;
}

- (RACSignal*) loadAllTasksForCurrentUser
{
    @weakify(self)
    
    RACSignal* loadAllUserTasksSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TasksAPIService sharedInstance] loadAllUserTasks]
         subscribeNext: ^(RACTuple* response) {
            
             @strongify(self)
             
             [self parseTasksForCurrentUser: response[0]
                             withCompletion: ^(BOOL isSuccess) {
                                
                                 [subscriber sendCompleted];
                                 
                             }];
             
        }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }];
        
        return nil;
    }];
    
    return loadAllUserTasksSignal;
}

- (RACSignal*) loadSelectedTaskAvailableActionsForTask: (ProjectTask*) task
{
    NSString* requestURL = [self buildRequestForGettingTaskAvailableActions: task];
    
    @weakify(self)
    
    RACSignal* loadAvailableActionsSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[[TasksAPIService sharedInstance] loadTaskAvailableActionsWithURL: requestURL]
          deliverOn: [RACScheduler mainThreadScheduler]]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseTaskAvailableActionsResponse: response[0]
                                            withTask: task
                                      withCompletion: ^(BOOL isSuccess) {
                                          
                                          [subscriber sendNext: nil];
                                          [subscriber sendCompleted];
                                          
                                      }];
             
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }];
        
        return nil;
        
    }];
    
    return loadAvailableActionsSignal;
}

- (RACSignal*) loadSelectedTaskLogs: (ProjectTask*) task
{
    NSString* requestURL = [self buildGetTaskLogsURL: task];
    
    @weakify(self)
    
    RACSignal* loadingTaskLogsSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [[[TasksAPIService sharedInstance] loadTaskLogs: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseNewTaskInfo: response[0]
                            forTask: (ProjectTask*) task
                     withCompletion: ^(BOOL isSuccess) {
                         
                         [subscriber sendNext: nil];
                         [subscriber sendCompleted];
                         
                     }];
             
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }];
        
        return nil;
    }];
    
    return loadingTaskLogsSignal;
}

- (void) changeSelectedStageForTask: (ProjectTask*)          task
                  withSelectedState: (BOOL)                  isSelected
                     withCompletion: (CompletionWithSuccess) completion
{
    if ( isSelected )
        [SVProgressHUD show];
    
    [DataManagerShared updateSelectedStateForTask: task
                                withSelectedState: isSelected
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       if ( isSelected )
                                       {
                                           NSArray* signals = @[[self loadSelectedTaskAvailableActionsForTask: task],
                                                                [[TaskCommentsService sharedInstance] getCommentsForSelectedTask],
                                                                [self loadSelectedTaskLogs: task]];
                                           
                                           RACSignal* loadSelectedTaskInfoSignal = [RACSignal combineLatest: signals];
                                           
                                           [loadSelectedTaskInfoSignal subscribeCompleted: ^{
                                               
                                               if ( completion )
                                                   completion(isSuccess);
                                               
                                               [SVProgressHUD dismiss];
                                               
                                           }];
                                       }
                                       else
                                       {
                                           if ( completion )
                                               completion(isSuccess);
                                       }
                                       
                                   }];
}

- (RACSignal*) createNewTaskWithInfo: (NewTask*) task
                           isSubtask: (BOOL)     isSubtask
{
    NSDictionary* requestParameters = [self buildNewTaskParameter: task
                                                        isSubtask: isSubtask];
    
    @weakify(self)
    
    RACSignal* createNewTaskSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[[TasksAPIService sharedInstance] createNewTaskWithParameter: requestParameters]
         deliverOn: [RACScheduler mainThreadScheduler]]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             if ( isSubtask )
             {
                 [self parseNewTaskInfo: response[0]
                         withCompletion: ^(BOOL isSuccess) {
                             
                             [subscriber sendNext: nil];
                             [subscriber sendCompleted];
                             
                         }];
             }
             else
             {
                 [self parseTasksForProjectFromResponse: @[response[0]]
                                         withCompletion:^(BOOL isSuccess) {
                                             
                                             [subscriber sendNext: nil];
                                             [subscriber sendCompleted];
                                             
                                         }];
             }
             
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }];
        
        return nil;
    }];
    
    return createNewTaskSignal;
}

- (RACSignal*) deleteTask: (ProjectTask*) task
             withSubtasks: (BOOL)         subtasks
{
    NSString* requestURL            = [self buildDeleteTaskURL: task];
    NSDictionary* requestParameters = @{@"saveChildTasks" : @(subtasks)};

    @weakify(self)
    
    RACSignal* deleteTaskSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TasksAPIService sharedInstance] deleteTaskWithURL: requestURL
                                             withParameters: requestParameters]
         subscribeNext: ^(RACTuple* response) {
             
             NSLog(@"<INFO> Task delete resopnse %@", response);
             
             @strongify(self)
             
             [self deleteTaskFromDataBase: task
                         withDeleteOption: subtasks
                           withCompletion: ^(BOOL isSuccess) {
                              
                               [subscriber sendNext: nil];
                               [subscriber sendCompleted];
                               
                           }];
             
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
             NSLog(@"<ERROR> with deleting task on server %@", error.userInfo);
             
         }];
        
        
        return nil;
    }];
    
    return deleteTaskSignal;
}

#pragma mark - Data base methods -

- (void) parseTasksForProjectFromResponse: (NSArray*)               response
                           withCompletion: (CompletionWithSuccess) completion
{
    NSError* parsingError = nil;
    NSArray* tasks        = [ProjectTaskModel arrayOfModelsFromDictionaries: response
                                                                      error: &parsingError];
    
    if ( parsingError )
    {
        NSLog(@"<ERROR> Error with parsing tasks response %@", parsingError.localizedDescription);
        
        [SVProgressHUD showErrorWithStatus: @"Возникла ошибка при попытке загрузки доступных действий над задачей."];
    }
    else
    {
        [DataManagerShared persistTasks: tasks
                         withCompletion: completion];
    }
}

- (void) parseTasksForCurrentUser: (NSDictionary*)         response
                   withCompletion: (CompletionWithSuccess) completion
{
    NSError* parsingError              = nil;
    TasksGroupedByProjects* parsedInfo = [[TasksGroupedByProjects alloc] initWithDictionary: response
                                                                                      error: &parsingError];
    
    if ( parsingError )
    {
        NSLog(@"<ERROR> Error with parsing tasks response: \n%@", parsingError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistTasksForProjects: parsedInfo
                                    withCompletion: completion];
    }
}

- (void) parseTaskAvailableActionsResponse: (NSDictionary*)         response
                                  withTask: (ProjectTask*)          task
                            withCompletion: (CompletionWithSuccess) completion
{
    NSError* parsingError                           = nil;
    TaskAvailableActionsModel* taskAvailableActions = [[TaskAvailableActionsModel alloc] initWithDictionary: response
                                                                                                      error: &parsingError];
    
    if ( parsingError )
    {
        NSLog(@"<ERROR> Error with parsing task available actions: %@", parsingError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistTaskAvailableActionsForSelectedTask: taskAvailableActions
                                                       withCompletion: completion];
    }
}

- (void) parseNewTaskInfo: (NSDictionary*)         response
           withCompletion: (CompletionWithSuccess) completion
{
    NSError* parsingError      = nil;
    ProjectTaskModel* taskInfo = [[ProjectTaskModel alloc] initWithDictionary: response
                                                                        error: &parsingError];
    
    if ( parsingError )
    {
        NSLog(@"<ERROR> Error with parsing new tasks response: \n%@", parsingError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistNewSubtask: taskInfo
                              withCompletion: completion];
    }
}

- (ProjectTask*) getUpdatedSelectedTask
{
    ProjectTask* task = [DataManagerShared getSelectedTask];
    
    return task;
}

- (void) parseTaskLogsResponse: (NSDictionary*)         response
                       forTask: (ProjectTask*)          task
                withCompletion: (CompletionWithSuccess) completion
{
    NSError* parseError = nil;
    
    
    if ( parseError )
    {
        NSLog(@"<ERROR> with parsing task logs response %@", parseError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistNewLogs: @[]
                                  forTask: task
                           withCompletion: completion];
    }
}

#pragma mark - Internal methods -


- (NSString*) buildRequestForGettingTaskAvailableActions: (ProjectTask*) task
{
    NSString* requestURL = projectTaskAvailableActionsURL;
    
    requestURL = [requestURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                       withString: task.projectId.stringValue];
    requestURL = [requestURL stringByReplacingOccurrencesOfString: @"{taskId}"
                                                       withString: task.taskID.stringValue];
    
    return requestURL;
}

- (NSDictionary*) buildNewTaskParameter: (NewTask*) taskInfo
                              isSubtask: (BOOL)     subtask
{
    ProjectInfo* taskProject              = [DataManagerShared getSelectedProjectInfo];
    NSMutableDictionary* newTaskParameter = [NSMutableDictionary new];
    
    newTaskParameter[@"title"] = taskInfo.taskName;
    
    if ( taskInfo.taskDescription )
        newTaskParameter[@"description"] = taskInfo.taskDescription;

    newTaskParameter[@"isUrgent"]           = @(taskInfo.terms.isUrgent);
    newTaskParameter[@"projectId"]          = taskProject.projectID;
    newTaskParameter[@"isIncludedRestDays"] = @(taskInfo.terms.includingWeekends);
    newTaskParameter[@"taskAccess"]         = @(taskInfo.isHiddenTask);
    newTaskParameter[@"files"]              = @[];
    newTaskParameter[@"marker"]             = @{};
    newTaskParameter[@"ownerUserId"]        = [[UserInfoService sharedInstance] getUserID];
    newTaskParameter[@"isAllRooms"]         = @NO;
    
    if ( taskInfo.terms.startDate )
    {
        newTaskParameter[@"startDate"] = [NSDate stringFromDate: taskInfo.terms.startDate
                                                     withFormat: @"dd.MM.yyyy"];
    }
    
    if ( taskInfo.terms.endDate )
    {
        newTaskParameter[@"endDate"] = [NSDate stringFromDate: taskInfo.terms.endDate
                                                   withFormat: @"dd.MM.yyyy"];
    }
    
    newTaskParameter[@"duration"] = @(taskInfo.terms.duration);
    newTaskParameter[@"taskType"] = @(taskInfo.taskType);
    
    // Room model
    if ( taskInfo.room )
    {
        NSDictionary* roomModelDic     = @{@"id"      : taskInfo.room.roomID,
                                           @"levelId" : taskInfo.room.roomLevel.roomLevelID};
        newTaskParameter[@"rooms"] = roomModelDic;
    }
    else
    {
        newTaskParameter[@"rooms"] = @{};
    }
    
    
    // Stage Model
    if ( taskInfo.stage )
    {
        NSDictionary* stageModelDic     = @{@"id"       : taskInfo.stage.stageID,
                                            @"title"    : taskInfo.stage.title,
                                            @"isCommon" : taskInfo.stage.isCommon};
        newTaskParameter[@"stage"] = stageModelDic;
    }
    else
    {
        newTaskParameter[@"stage"] = @{};
    }
    
    // Work Area Model
    if ( taskInfo.system )
    {
        NSDictionary* workAreaModelDic     = @{@"id" : taskInfo.system.systemID,
                                               @"title" : taskInfo.system.title,
                                               @"shortTitle" : taskInfo.system.shortTitle,
                                               @"hasTasks"   : taskInfo.system.hasTasks};
        
        newTaskParameter[@"workArea"] = workAreaModelDic;
    }
    else
    {
        newTaskParameter[@"workArea"] = @{};
    }
    
    // Task Role Assignment Models
    NSMutableArray* taskRoleAssignmentModelsArr = [NSMutableArray array];
    
    [taskInfo.responsible enumerateObjectsUsingBlock: ^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [taskRoleAssignmentModelsArr addObject: @{@"taskRoleType" : @0,
                                                  @"projectRoleAssignmentId" : obj.userId}];
        
    }];
    
    [taskInfo.claiming enumerateObjectsUsingBlock: ^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [taskRoleAssignmentModelsArr addObject: @{@"taskRoleType" : @1,
                                                  @"projectRoleAssignmentId" : obj.userId}];
        
    }];
    
    [taskInfo.observers enumerateObjectsUsingBlock: ^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [taskRoleAssignmentModelsArr addObject: @{@"taskRoleType" : @2,
                                                  @"projectRoleAssignmentId" : obj.userId}];
        
    }];
    
    newTaskParameter[@"taskRoleAssignmentModels"] = taskRoleAssignmentModelsArr;
    
    
    if ( subtask )
    {
        ProjectTask* selectedTask = [DataManagerShared getSelectedTask];
        
        newTaskParameter[@"parentTaskId"] = selectedTask.taskID;
    }
    
    return newTaskParameter.copy;
}

- (NSString*) buildDeleteTaskURL: (ProjectTask*) task
{
    NSString* requestURL = [deleteTaskURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                    withString: task.projectId.stringValue];
    
    requestURL = [requestURL stringByReplacingOccurrencesOfString: @"{taskId}"
                                                       withString: task.taskID.stringValue];
    
    return requestURL;
}

- (NSString*) buildGetTaskLogsURL: (ProjectTask*) task
{
    NSString* requestURL = [logsTaskURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                  withString: task.projectId.stringValue];
    
    requestURL = [requestURL stringByReplacingOccurrencesOfString: @"{taskId}"
                                                       withString: task.taskID.stringValue];
    
    return requestURL;
}

- (void) deleteTaskFromDataBase: (ProjectTask*)          task
               withDeleteOption: (BOOL)                  withSubtask
                 withCompletion: (CompletionWithSuccess) completion
{
    [DataManagerShared deleteTaskWithInfo: task
                              withSubtask: withSubtask
                           withCompletion: completion];
}

@end
