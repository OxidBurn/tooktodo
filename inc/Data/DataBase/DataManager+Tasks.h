//
//  DataManager+Tasks.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "ProjectTask.h"
#import "TasksGroupedByProjects.h"


@interface DataManager (Tasks)

- (void) persistTasks: (NSArray*)              tasks
       withCompletion: (CompletionWithSuccess) completion;

- (void) persistTasksForProjects: (TasksGroupedByProjects*) info
                  withCompletion: (CompletionWithSuccess)   completion;

@end
