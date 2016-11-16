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

// Categories
#import "DataManager+Tasks.h"
#import "DataManager+TaskAvailableActions.h"
#import "DataManager+ProjectInfo.h"
#import "NSDate+Helper.h"

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

- (void) changeSelectedStageForTask: (ProjectTask*) task
                  withSelectedState: (BOOL)         isSelected
{
    [DataManagerShared updateSelectedStateForTask: task
                                withSelectedState: isSelected
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       if ( isSelected )
                                       {
                                           [[self loadSelectedTaskAvailableActionsForTask: task]
                                            subscribeNext: ^(id x) {
                                                
                                            }
                                            error:^(NSError *error) {
                                                
                                            }];
                                           
                                           [[[TaskCommentsService sharedInstance] getCommentsForSelectedTask]
                                            subscribeNext: ^(id x) {
                                                
                                            }
                                            error: ^(NSError *error) {
                                                
                                            }];
                                       }
                                       
                                   }];
}

- (RACSignal*) createNewTaskWithInfo: (NewTask*) task
{
    NSDictionary* requestParameters = [self buildNewTaskParameter: task];
    
    RACSignal* createNewTaskSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [[[[TasksAPIService sharedInstance] createNewTaskWithParameter: requestParameters]
         deliverOn: [RACScheduler mainThreadScheduler]]
         subscribeNext: ^(RACTuple* response) {
             
             NSLog(@"Response: %@", response);
             
         }
         error: ^(NSError *error) {
             
             [subscriber sendError: error];
             
         }];
        
        return nil;
    }];
    
    return createNewTaskSignal;
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
    NSError* parsingError = nil;
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
{
    ProjectInfo* taskProject = [DataManagerShared getSelectedProjectInfo];
    NSMutableDictionary* newTaskParameter = [NSMutableDictionary new];
    
    newTaskParameter[@"title"] = taskInfo.taskName;
    
    if ( taskInfo.taskDescription )
        newTaskParameter[@"description"] = taskInfo.taskDescription;

    newTaskParameter[@"isUrgent"]           = @(taskInfo.terms.isUrgent);
    newTaskParameter[@"projectId"]          = taskProject.projectID;
    newTaskParameter[@"isIncludedRestDays"] = @(taskInfo.terms.includingWeekends);
    newTaskParameter[@"taskAccess"]         = @(taskInfo.isHiddenTask);
    newTaskParameter[@"files"]              = @[];
    newTaskParameter[@"markerModel"]        = @{};
    
    if ( taskInfo.terms.startDate )
    {
    newTaskParameter[@"startDate"] = [NSDate stringFromDate: taskInfo.terms.startDate
                                                 withFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSS"];
    }
    
    if ( taskInfo.terms.endDate )
    {
        newTaskParameter[@"endDate"] = [NSDate stringFromDate: taskInfo.terms.endDate
                                                   withFormat: @"yyyy-MM-dd'T'HH:mm:ss.SSS"];
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
                                               @"shortTitle" : taskInfo.system.shortTitle};
        
        newTaskParameter[@"workAreaModel"] = workAreaModelDic;
    }
    else
    {
        newTaskParameter[@"workAreaModel"] = @{};
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
    
    
    return newTaskParameter.copy;
}

@end
