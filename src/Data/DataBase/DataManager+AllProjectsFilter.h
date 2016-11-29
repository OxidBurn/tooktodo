//
//  DataManager+AllProjectsFilter.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/28/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "TaskFilterConfiguration.h"
#import "AllProjectTasksFilterContent+CoreDataClass.h"
#import "FilterTagParameterInfo.h"

@interface DataManager (AllProjectsFilter)

- (void) saveAllProjectTasksFilterContent: (TaskFilterConfiguration*) config
                           withCompletion: (CompletionWithSuccess)    completion;

- (void) resetAllProjectsTasksFilterContentWithCompletion: (CompletionWithSuccess) completion;

- (AllProjectTasksFilterContent*) getAllProjectsTaskFilterContent;

- (NSArray*) applyAllProjectsFiltersToTasks: (NSArray*) tasks;

- (NSArray*) applyFiltersToProject: (NSArray*) projects;

- (void) deleteAllProjectsTasksFilterItem: (FilterTagParameterInfo*) info
                           withCompletion: (CompletionWithSuccess)   completion;

@end
