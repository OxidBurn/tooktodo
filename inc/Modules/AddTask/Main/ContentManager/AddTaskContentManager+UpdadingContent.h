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

- (NSArray*) updateSelectedSystem: (ProjectSystem*) system;

- (NSArray*) updateSelectedStage: (ProjectTaskStage*) stage;

- (NSArray*) updateSelectedInfo: (id) info;

- (NSArray*) updateSelectedTaskType: (TaskType)  type
                withDescription: (NSString*) typeDescription
                      withColor: (UIColor*)  typeColor;

- (NSArray*) updateTerms: (TermsData*) terms;

- (NSArray*) updateTaskDescription: (NSString*) taskDescription;

@end
