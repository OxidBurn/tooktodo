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
#import "TaskAvailableActionsModel.h"
#import "ProjectTask+CoreDataClass.h"


@interface DataManager (Tasks)

// persist methods
- (void) persistTasks: (NSArray*)              tasks
       withCompletion: (CompletionWithSuccess) completion;

- (void) persistTasksForProjects: (TasksGroupedByProjects*) info
                  withCompletion: (CompletionWithSuccess)   completion;

- (void) persistProjectRoleType: (ProjectRoleTypeModel*)   info
               forProjectInvite: (ProjectInviteInfo*)      invite
                      inContext: (NSManagedObjectContext*) context;

- (void) persistNewSubtask: (ProjectTaskModel*)     info
            withCompletion: (CompletionWithSuccess) completion;

// update
- (void) updateSelectedTaskInfo: (ProjectTask*)          task
                    withNewInfo: (ProjectTaskModel*)     info
                 withCompletion: (CompletionWithSuccess) completion;

- (void) updateExpandedStateOfStage: (ProjectTaskStage*)     stageInfo
                     withCompletion: (CompletionWithSuccess) completion;

- (void) changeItemSelectedState: (BOOL)                    isSelected
                         forItem: (ProjectRoleAssignments*) assignment;

- (void) updateSelectedStateForTask: (ProjectTask*)          task
                  withSelectedState: (BOOL)                  isSelected
                     withCompletion: (CompletionWithSuccess) completion;

- (void) updateStatusType: (NSNumber*)             newStatus
    withStatusDescription: (NSString*)             statusDescription
           withCompletion: (CompletionWithSuccess) completion;

// delete
- (void) deleteTaskWithInfo: (ProjectTask*)          task
                withSubtask: (BOOL)                  subtask
             withCompletion: (CompletionWithSuccess) completion;

// Get methods
- (ProjectRoleAssignments*) getSelectedProjectRoleAssignment;

- (NSArray*) getStagesForCurrentProject;

- (ProjectTask*) getSelectedTask;

- (ProjectTask*) getSelectedTaskInContext: (NSManagedObjectContext*) context;

@end
