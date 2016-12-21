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
#import "TaskLogsModel.h"
#import "ProjectTaskStageModel.h"

// Categories
#import "DataManager+Tasks.h"
#import "DataManager+TaskAvailableActions.h"
#import "DataManager+ProjectInfo.h"
#import "NSDate+Helper.h"
#import "DataManager+TaskLogs.h"
#import "NSMutableArray+Safe.h"

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

- (RACSignal*) loadAllTasksForProject: (ProjectInfo*) project
{
    NSString* requestURL = [projectTasksByStagesURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                              withString: project.projectID.stringValue];
    
    @weakify(self)
    
    RACSignal* loadTasksForProjectSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[[TasksAPIService sharedInstance] loadTasksForProjectWithURL: requestURL]
          deliverOn: [RACScheduler mainThreadScheduler]]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseTasksForProjectFromResponse: response[0][@"stages"]
                                         forProject: project
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
    __block NSMutableArray* signalsArray = [NSMutableArray array];
    
    NSArray* allProjects = [DataManagerShared getAllProjects];
    
    [allProjects enumerateObjectsUsingBlock: ^(ProjectInfo*  _Nonnull project, NSUInteger idx, BOOL * _Nonnull stop) {
        
        RACSignal* loadProjectTasksSignal = [self loadAllTasksForProject: project];
        
        [signalsArray addObject: loadProjectTasksSignal];
        
    }];
    
    RACSignal* loadAllUserTasksSignal = [RACSignal combineLatest: signalsArray];
    
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
             
             [self parseTaskLogsResponse: response[0]
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
    {
        [SVProgressHUD show];
        SharedApplication.networkActivityIndicatorVisible = YES;
    }
    
    [DataManagerShared updateSelectedStateForTask: task
                                withSelectedState: isSelected
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       if ( isSelected )
                                       {
                                           NSArray* signals = @[[self loadSelectedTaskInfoWithCompletion],
                                                                [self loadSelectedTaskAvailableActionsForTask: task],
                                                                [[TaskCommentsService sharedInstance] getCommentsForSelectedTask],
                                                                [self loadSelectedTaskLogs: task]];
                                           
                                           RACSignal* loadSelectedTaskInfoSignal = [RACSignal combineLatest: signals];
                                           
                                           [loadSelectedTaskInfoSignal subscribeError:^(NSError *error) {
                                               
                                               [SVProgressHUD show];
                                               
                                           } completed: ^{
                                               
                                               if ( completion )
                                                   completion(isSuccess);
                                               
                                               SharedApplication.networkActivityIndicatorVisible = NO;
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
             
             [self parseNewTaskInfo: response[0]
                          isSubTask: isSubtask
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

- (RACSignal*) updateStatusForSelectedTask: (TaskStatusType) status
{
    NSString* requestURL           = [self buildUpdateTaskStatusURL];
    NSDictionary* requestParameter = [self getUpdateTaskStatusParameter: status];
    
    @weakify(self)
    
    RACSignal* updateStatusSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
       
        RACSignal* signal = nil;
        
        @strongify(self)
        
        if ( status == TaskApproveStatusType )
        {
            signal = [self setSelectedTaskToApproval];
        }
        else
        {
            signal = [self updateStatusForTask: requestURL
                          withRequestParameter: requestParameter];
        }
        
        [signal subscribeNext: ^(RACTuple* response) {
            
            ProjectTask* currentTask = [DataManagerShared getSelectedTask];
            
            [self parseSelectedTaskInfo: response[0]
                               withTask: currentTask
                         withCompletion: ^(BOOL isSuccess) {
                             
                             [[self loadSelectedTaskAvailableActionsForTask: currentTask]
                              subscribeCompleted: ^{
                                  
                                  [subscriber sendNext: nil];
                                  [subscriber sendCompleted];
                                  
                              }];
                             
                         }];
            
        }
                        error: ^(NSError *error) {
                            
                            [subscriber sendError: error];
                            
                        }];
        
        return nil;
    }];
    
    return updateStatusSignal;
}

- (RACSignal*) sendReworkStatusMessage: (NSString*) message
{
    NSString* requestURL           = [self buildSendReworkStatusMessageURL];
    NSDictionary* requestParameter = [self buildSendReworkStatusMessageParameter: message];
    
    RACSignal* sendReworkStatusMessage = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TasksAPIService sharedInstance] sendReworkStatusMessage: requestURL
                                                   withParameters: requestParameter]
         subscribeNext: ^(RACTuple* response) {
             
             ProjectTask* task = [DataManagerShared getSelectedTask];
             
             [self parseSelectedTaskInfo: response[0]
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
    
    return sendReworkStatusMessage;
}

- (RACSignal*) requestToCancelTask: (NSString*) message
{
    NSString* requestURL           = [self buildCancelTaskRequestURL];
    NSDictionary* requestParameter = @{@"message" : message};
    
    @weakify(self)
    
    RACSignal* cancelRequestSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TasksAPIService sharedInstance] taskCancelRequest: requestURL
                                             withParameters: requestParameter]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             ProjectTask* currentTask = [DataManagerShared getSelectedTask];
             
             [self parseSelectedTaskInfo: response[0]
                                withTask: currentTask
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
    
    return cancelRequestSignal;
}

- (RACSignal*) loadSelectedTaskInfoWithCompletion
{
    ProjectTask* task    = [self getUpdatedSelectedTask];
    NSString* requestURL = [self buildGetTaskInfoURL: task];
    
    @weakify(self)
    
    RACSignal* loadTaskInfo = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
       
        [[[TasksAPIService sharedInstance] loadTaskInfoWithURL: requestURL]
         subscribeNext: ^(RACTuple* response) {
             
             @strongify(self)
             
             [self parseSelectedTaskInfo: response[0]
                                withTask: task
                          withCompletion: ^(BOOL isSuccess) {
                              
                              [subscriber sendNext: nil];
                              [subscriber sendCompleted];
                              
                          }];
             
         }
         error: ^(NSError *error) {
             
             NSLog(@"<ERROR> with loading task info %@", error.localizedDescription);
             
             [subscriber sendError: error];
             
         }];
        
        return nil;
    }];
    
    return loadTaskInfo;
}

- (RACSignal*) updateTaskInfo: (NewTask*) newInfo
{
    ProjectTask* currentTask       = [self getUpdatedSelectedTask];
    NSString* requestURL           = [self buildGetTaskInfoURL: currentTask];
    NSDictionary* requestParameter = [self buildNewTaskParameter: newInfo
                                                       isSubtask: NO];
    
    RACSignal* updateTaskSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[TasksAPIService sharedInstance] updateTaskInfo: requestURL
                                           withParameters: requestParameter]
         subscribeNext: ^(RACTuple* response) {
             
             [self parseSelectedTaskInfo: response[0]
                                withTask: currentTask
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
    
    return updateTaskSignal;
}

- (RACSignal*) setSelectedTaskToApproval
{
    NSString* requestURL = [self buildSetTaskToApprovalRequestURL];
    
    return [[TasksAPIService sharedInstance] setTaskToApproval: requestURL];
}

- (RACSignal*) updateStatusForTask: (NSString*)     requestURL
              withRequestParameter: (NSDictionary*) parameter
{
    return [[TasksAPIService sharedInstance] updateTaskStatus: requestURL
                                                withParameter: parameter];
}

#pragma mark - Data base methods -

- (void) parseTasksForProjectFromResponse: (NSArray*)              response
                               forProject: (ProjectInfo*)          project
                           withCompletion: (CompletionWithSuccess) completion
{
    NSError* parsingError = nil;
    NSArray* tasks        = [ProjectTaskStageModel arrayOfModelsFromDictionaries: response
                                                                           error: &parsingError];
    
    if ( parsingError )
    {
        NSLog(@"<ERROR> Error with parsing tasks response %@", parsingError.localizedDescription);
        
        [Utils showErrorAlertWithMessage: @"Возникла ошибка при попытке загрузки доступных действий над задачей."];
    }
    else
    {
        [DataManagerShared persistTasks: tasks
                             forProject: project
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

- (void) parseSelectedTaskInfo: (NSDictionary*)         response
                      withTask: (ProjectTask*)          task
                withCompletion: (CompletionWithSuccess) completion
{
    NSError* parsingError      = nil;
    ProjectTaskModel* taskInfo = [[ProjectTaskModel alloc] initWithDictionary: response
                                                                        error: &parsingError];
    
    if ( parsingError )
    {
        NSLog(@"<ERROR> with parsing selected task info: %@", parsingError.localizedDescription);
    }
    else
    {
        [DataManagerShared updateSelectedTaskInfo: task
                                      withNewInfo: taskInfo
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
                isSubTask: (BOOL)                  isSubTask
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
        if ( isSubTask )
        {
            [DataManagerShared persistNewSubtask: taskInfo
                                  withCompletion: completion];
        }
        else
        {
            [DataManagerShared persistNewTaskForSelectedProject: taskInfo
                                                 withCompletion: completion];
        }
    }
}

- (ProjectTask*) getUpdatedSelectedTask
{
    ProjectTask* task = [DataManagerShared getSelectedTask];
    
    return task;
}


#pragma mark - Parsing responses from server -

- (void) parseTaskLogsResponse: (NSDictionary*)         response
                withCompletion: (CompletionWithSuccess) completion
{
    NSError* parseError     = nil;
    TaskLogsModel* taskLogs = [[TaskLogsModel alloc] initWithDictionary: response
                                                                  error: &parseError];
    
    if ( parseError )
    {
        NSLog(@"<ERROR> with parsing task logs response %@", parseError.localizedDescription);
    }
    else
    {
        [DataManagerShared persistNewLogs: taskLogs.list
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
        newTaskParameter[@"roomModel"] = roomModelDic;
    }
    else
    {
        newTaskParameter[@"roomModel"] = @{};
    }
    
    
    // Stage Model
    if ( taskInfo.stage )
    {
        NSDictionary* stageModelDic     = @{@"id"       : taskInfo.stage.stageID,
                                            @"title"    : taskInfo.stage.title,
                                            @"isCommon" : taskInfo.stage.isCommon};
        newTaskParameter[@"stageModel"] = stageModelDic;
    }
    else
    {
        newTaskParameter[@"stageModel"] = @{};
    }
    
    // Work Area Model
    if ( taskInfo.system )
    {
        NSDictionary* workAreaModelDic     = @{@"id" : taskInfo.system.systemID,
                                               @"title" : taskInfo.system.title,
                                               @"shortTitle" : taskInfo.system.shortTitle,
                                               @"hasTasks"   : taskInfo.system.hasTasks};
        
        newTaskParameter[@"workAreaModel"] = workAreaModelDic;
    }
    else
    {
        newTaskParameter[@"workAreaModel"] = @{};
    }
    
    // Task Role Assignment Models
    NSMutableArray* taskRoleAssignmentModelsArr = [NSMutableArray array];
    
    [taskInfo.responsible enumerateObjectsUsingBlock: ^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( obj.userId )
        {
            [taskRoleAssignmentModelsArr safeAddObject: @{@"taskRoleType"            : @0,
                                                          @"projectRoleAssignmentId" : obj.userId}];
        }
        
    }];
    
    [taskInfo.claiming enumerateObjectsUsingBlock: ^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( obj.userId )
        {
            [taskRoleAssignmentModelsArr safeAddObject: @{@"taskRoleType"            : @1,
                                                          @"projectRoleAssignmentId" : obj.userId}];
        }
        
    }];
    
    [taskInfo.observers enumerateObjectsUsingBlock: ^(FilledTeamInfo* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( obj.userId )
        {
            [taskRoleAssignmentModelsArr safeAddObject: @{@"taskRoleType"            : @2,
                                                          @"projectRoleAssignmentId" : obj.userId}];
        }
        
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

- (NSString*) buildUpdateTaskStatusURL
{
    ProjectTask* currentTask = [DataManagerShared getSelectedTask];
    
    NSString* requestURL = [updateTaskStatusURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                          withString: currentTask.projectId.stringValue];
    
    requestURL = [requestURL stringByReplacingOccurrencesOfString: @"{taskId}"
                                                       withString: currentTask.taskID.stringValue];
    
    return requestURL;
}

- (NSDictionary*) getUpdateTaskStatusParameter: (TaskStatusType) status
{
    NSDictionary* requestParameter = @{@"status" : [NSString stringWithFormat: @"%lu", status]};
    
    return requestParameter;
}

- (NSString*) buildSendReworkStatusMessageURL
{
    ProjectTask* currentTask = [DataManagerShared getSelectedTask];
    
    NSString* requestURL = [sendReworkMessageURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                           withString: currentTask.projectId.stringValue];
    
    requestURL = [requestURL stringByReplacingOccurrencesOfString: @"{taskId}"
                                                       withString: currentTask.taskID.stringValue];
    
    return requestURL;
}

- (NSDictionary*) buildSendReworkStatusMessageParameter: (NSString*) message
{
    NSDictionary* requestParameter = @{@"message" : message};
    
    return requestParameter;
}

- (NSString*) buildGetTaskInfoURL: (ProjectTask*) task
{
    NSString* requestURL = [getTaskInfoURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                     withString: task.projectId.stringValue];
    
    requestURL = [requestURL stringByReplacingOccurrencesOfString: @"{taskId}"
                                                       withString: task.taskID.stringValue];
    
    return requestURL;
}

- (NSString*) buildSetTaskToApprovalRequestURL
{
    ProjectTask* currentTask = [DataManagerShared getSelectedTask];
    
    NSString* requestURL = [setTaskToApprovalURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                           withString: currentTask.project.projectID.stringValue];
    
    requestURL = [requestURL stringByReplacingOccurrencesOfString: @"{taskId}"
                                                       withString: currentTask.taskID.stringValue];
    
    return requestURL;
}

- (NSString*) buildCancelTaskRequestURL
{
    ProjectTask* currentTask = [DataManagerShared getSelectedTask];
    
    NSString* requestURL = [requestToCancelTaskURL stringByReplacingOccurrencesOfString: @"{projectId}"
                                                                             withString: currentTask.projectId.stringValue];
    
    requestURL = [requestURL stringByReplacingOccurrencesOfString: @"{taskId}"
                                                       withString: currentTask.taskID.stringValue];
    
    return requestURL;
}

@end
