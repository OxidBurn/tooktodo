//
//  FilterByAssigneeViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 24.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "ProjectsEnumerations.h"
#import "BaseMainViewController.h"

@protocol FilterByAssigneeViewControllerDelegate;

@interface FilterByAssigneeViewController : BaseMainViewController

// properties
@property (weak, nonatomic) id <FilterByAssigneeViewControllerDelegate> delegate;

// methods
- (void) updateFilterType: (FilterByAssigneeType) filterType
             withDelegate: (id)                   delegate;

- (void) fillSelectedUsersInfo: (NSArray*) selectedUsers;

@end


@protocol FilterByAssigneeViewControllerDelegate <NSObject>

- (void) returnSelectedAssigneesArray: (NSArray*)             selectedAssignees
                       withFilterType: (FilterByAssigneeType) filterType
                          withIndexes: (NSArray*)             indexesArray;

//- (void) returnSelectedResponsibleInfo: (NSArray*) selectedUsersArray;
//
//- (void) returnSelectedCreatorsInfo: (NSArray*) selectedCreators;
//
//- (void) returnSelectedApproversInfo: (NSArray*) selectedApprovers;

//- (void) returnSelectedClaimingInfo: (NSArray*) selectedClaiming;
//
//- (void) returnSelectedObserversInfo: (NSArray*) selectedObservers;

@end
