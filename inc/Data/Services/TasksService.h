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

@interface TasksService : NSObject

// properties


// methods

+ (instancetype) sharedInstance;

- (RACSignal*) loadAllTasksForProjectWithID: (NSNumber*) projectID;

- (RACSignal*) loadAllTasksForCurrentUser;

- (RACSignal*) loadSelectedTaskAvailableActionsForTask: (ProjectTask*) task;

- (void) changeSelectedStageForTask: (ProjectTask*) task
                  withSelectedState: (BOOL)         isSelected;

@end
