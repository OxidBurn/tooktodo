//
//  SelectResponsibleModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "FilledTeamInfo.h"
#import "ProjectsEnumerations.h"

@interface SelectResponsibleModel : NSObject

// methods

- (NSUInteger) getNumberOfRows;

- (FilledTeamInfo*) returnFilledUserInfoForIndex: (NSUInteger) index;

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath;

- (NSNumber*) getMemberTaskRoleTypeAtIndex: (NSUInteger) index;

- (void) fillContollerTypeSelection: (ControllerTypeSelection) controllerType
                  withSelectedUsers: (NSArray*)                selectedUsers
                     withAllMembers: (NSArray*)                allMembers;

- (ControllerTypeSelection) returnControllerType;

- (BOOL) checkIfButtonIsEnabled;

- (void) updatePreviousCellIndexPath: (NSIndexPath*) indexPath;

- (NSIndexPath*) returnPreviousMarkedCellIndexPath;

- (NSArray*) returnSelectedResponsibleArray;

- (NSArray*) returnSelectedClaimingArray;

- (NSArray*) returnSelectedObserversArray;

- (NSArray*) returnAllMembersArray;

- (void) selectAll;

- (void) deselectAll;

- (void) configurateMembersArray;

@end
