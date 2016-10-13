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

- (void) persistProjectRoleType: (ProjectRoleTypeModel*)   info
               forProjectInvite: (ProjectInviteInfo*)      invite
                      inContext: (NSManagedObjectContext*) context;

- (void) updateExpandedStateOfStage: (ProjectTaskStage*)     stageInfo
                     withCompletion: (CompletionWithSuccess) completion;

- (ProjectRoleAssignments*) getSelectedProjectRoleAssignment;

- (void) changeItemSelectedState: (BOOL)                    isSelected
                         forItem: (ProjectRoleAssignments*) assignment;

- (NSArray*) getStagesForCurrentProject;

- (void) updateSelectedStateForTask: (ProjectTask*) task
                  withSelectedState: (BOOL)         isSelected;

- (ProjectTask*) getSelectedTask;

@end
