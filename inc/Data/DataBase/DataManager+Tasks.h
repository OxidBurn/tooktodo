//
//  DataManager+Tasks.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "ProjectTask+CoreDataClass.h"
#import "TasksGroupedByProjects.h"
#import "ProjectRoleAssignments+CoreDataClass.h"
#import "FilledTeamInfo.h"


@interface DataManager (Tasks)

- (void) persistTasks: (NSArray*)              tasks
       withCompletion: (CompletionWithSuccess) completion;

- (void) persistTasksForProjects: (TasksGroupedByProjects*) info
                  withCompletion: (CompletionWithSuccess)   completion;

- (void) updateExpandedStateOfStage: (ProjectTaskStage*)     stageInfo
                     withCompletion: (CompletionWithSuccess) completion;

- (ProjectTaskRoleAssignments*) getSelectedItem;

- (void) changeItemSelectedState: (BOOL)                    isSelected
                   forAssignment: (ProjectRoleAssignments*) assignment;

@end
