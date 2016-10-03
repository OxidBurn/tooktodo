//
//  SelectResponsibleModel.h
//  TookTODO
//
//  Created by Глеб on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "FilledTeamInfo.h"
#import "ProjectsEnumerations.h"

@interface SelectResponsibleModel : NSObject

// methods

- (void) updateTeamInfoWithCompletion: (CompletionWithSuccess) completion;

- (NSUInteger) getNumberOfRows;

- (FilledTeamInfo*) returnFilledUserInfoForIndex: (NSUInteger) index;

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath;

- (BOOL) getStateForMemberAtIndex: (NSUInteger) index;

- (void) fillContollerTypeSelection: (ControllerTypeSelection) controllerType;

- (ControllerTypeSelection) returnControllerType;

- (BOOL) checkIfButtonIsEnabled;

- (void) updatePreviousCellIndexPath: (NSIndexPath*) indexPath;

- (NSIndexPath*) returnPreviousMarkedCellIndexPath;

- (void) fillSelectedUsersInfo: (NSArray*) selectedUsers;

- (NSArray*) returnSelectedResponsibleArray;

- (NSArray*) returnSelectedClaimingArray;

- (NSArray*) returnSelectedObserversArray;

- (void) selectAll;

- (void) deselectAll;

@end
