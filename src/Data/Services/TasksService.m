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

// Categories
#import "DataManager+Tasks.h"
#import "DataManager+TaskAvailableActions.h"

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
                                       }
                                       
                                   }];
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

@end
