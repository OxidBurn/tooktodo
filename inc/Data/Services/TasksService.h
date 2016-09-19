//
//  TasksService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

@interface TasksService : NSObject

// properties


// methods

+ (instancetype) sharedInstance;

- (RACSignal*) loadAllTasksForProjectWithID: (NSNumber*) projectID;

- (RACSignal*) loadAllTasksForCurrentUser;

@end
