//
//  TaskFiltersService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//


// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "TaskFilterConfiguration.h"

@interface TaskFiltersService : NSObject

// methods

+ (instancetype) sharedInstance;

- (RACSignal*) loadAllTaskFiltersInfo: (NSNumber*) projectID;

- (void) saveFilterConfiguration: (TaskFilterConfiguration*) config
                  withCompletion: (CompletionWithSuccess)    completion;

- (void) saveAllProjectsFilterConfiguration: (TaskFilterConfiguration*) config
                             withCompletion: (CompletionWithSuccess)    completion;

- (void) resetFilterConfigurationForCurrentProject: (CompletionWithSuccess) completion;

- (void) resetAllProjectsFilterConfigurationForCurrentProject: (CompletionWithSuccess) completion;

@end
