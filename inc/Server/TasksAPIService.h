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

- (RACSignal*) loadAllUserTasks;

@end
