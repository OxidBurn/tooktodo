//
//  AddTaskContentManager+UpdadingContent.h
//  TookTODO
//
//  Created by Nikolay Chaban on 14.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskContentManager.h"

@interface AddTaskContentManager (UpdadingContent)

// methods
- (void) fillDefaultStage: (ProjectTaskStage*)     stage
           andHiddenState: (BOOL)                  isHidden
        forControllerType: (AddTaskControllerType) controllerType;

// model delegate updating methods
- (NSArray*) updateTaskHiddenProperty: (BOOL) isHidden;

- (NSArray*) updateSelectedResponsibleInfo: (NSArray*) selectedUsersArray;

- (NSArray*) updateSelectedClaimingInfo: (NSArray*) selectedClaiming;

- (NSArray*) updateSelectedObserversInfo: (NSArray*) selectedObservers;

- (void) updateSelectedSystem: (ProjectSystem*) system;

- (void) updateSelectedStage: (ProjectTaskStage*) stage;

- (void) updateSelectedInfo: (id) info;

- (void) updateSelectedTaskType: (TaskType)  type
                withDescription: (NSString*) typeDescription
                      withColor: (UIColor*)  typeColor;

- (void) updateTerms: (TermsData*) terms;

- (void) updateTaskDescription: (NSString*) taskDescription;

@end
