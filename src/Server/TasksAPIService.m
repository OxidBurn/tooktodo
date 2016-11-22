//
//  TasksAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksAPIService.h"

@implementation TasksAPIService

#pragma mark - Shared -
+ (instancetype) sharedInstance
{
    static TasksAPIService* instance = nil;

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        instance = [TasksAPIService new];
    });

    return instance;
}


#pragma mark - Public methods -

- (RACSignal*) loadTasksForProjectWithURL: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}

- (RACSignal*) loadAllUserTasks
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: allUserTasksURL parameters: nil] logError] replayLazily];
}

- (RACSignal*) loadTaskAvailableActionsWithURL: (NSString*) url
{
    AFHTTPRequestOperationManager* requestManager = [self getDefaultManager];
    
    return [[[requestManager rac_GET: url parameters: nil] logError] replayLazily];
}

- (RACSignal*) createNewTaskWithParameter: (NSDictionary*) parameters
{
    AFHTTPRequestOperationManager* requestManager = [self getRawManager];
    
    return [[[requestManager rac_POST: createNewTaskURL parameters: parameters] logError] replayLazily];
}

- (RACSignal*) deleteTaskWithURL: (NSString*)     url
                  withParameters: (NSDictionary*) parameters
{
    AFHTTPRequestOperationManager* requestManager = [self getRawManager];
    
    return [[[requestManager rac_DELETE: url parameters: parameters] logError] replayLazily];
}

@end
