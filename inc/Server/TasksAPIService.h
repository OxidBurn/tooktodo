//
//  TasksAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "BaseApiService.h"

@interface TasksAPIService : BaseAPIService

// methods

+ (instancetype) sharedInstance;

- (RACSignal*) loadTasksForProjectWithURL: (NSString*) url;

- (RACSignal*) loadTaskInfoWithURL: (NSString*) url;

- (RACSignal*) loadAllUserTasks;

- (RACSignal*) loadTaskAvailableActionsWithURL: (NSString*) url;

- (RACSignal*) createNewTaskWithParameter: (NSDictionary*) parameters;

- (RACSignal*) deleteTaskWithURL: (NSString*)     url
                  withParameters: (NSDictionary*) parameters;

- (RACSignal*) loadTaskLogs: (NSString*) url;

- (RACSignal*) updateTaskStatus: (NSString*)     requestURL
                  withParameter: (NSDictionary*) parameter;

- (RACSignal*) sendReworkStatusMessage: (NSString*)     requestURL
                        withParameters: (NSDictionary*) parameter;

@end
