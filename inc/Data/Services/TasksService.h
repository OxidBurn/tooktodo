//
//  TasksService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "ProjectTask+CoreDataClass.h"
#import "NewTask.h"

@interface TasksService : NSObject

// properties


// methods

+ (instancetype) sharedInstance;

- (RACSignal*) loadAllTasksForProjectWithID: (NSNumber*) projectID;

- (RACSignal*) loadAllTasksForCurrentUser;

- (RACSignal*) loadSelectedTaskAvailableActionsForTask: (ProjectTask*) task;

- (RACSignal*) loadSelectedTaskLogs: (ProjectTask*) task;

- (void) changeSelectedStageForTask: (ProjectTask*)          task
                  withSelectedState: (BOOL)                  isSelected
                     withCompletion: (CompletionWithSuccess) completion;

- (RACSignal*) createNewTaskWithInfo: (NewTask*) task
                           isSubtask: (BOOL)     isSubtask;

- (ProjectTask*) getUpdatedSelectedTask;

- (RACSignal*) deleteTask: (ProjectTask*) task
             withSubtasks: (BOOL)         subtasks;

- (RACSignal*) updateStatusForSelectedTask: (TaskStatusType) status;

- (RACSignal*) sendReworkStatusMessage: (NSString*) message;

@end
