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

@protocol FilterByAssigneeViewControllerDelegate;

@interface FilterByAssigneeViewController : UIViewController

// properties
@property (weak, nonatomic) id <FilterByAssigneeViewControllerDelegate> delegate;

// methods
- (void) updateFilterType: (FilterByAssigneeType) filterType
             withDelegate: (id)                   delegate;

- (void) fillSelectedUsersInfo: (NSArray*) selectedUsers;

@end


@protocol FilterByAssigneeViewControllerDelegate <NSObject>

- (void) returnSelectedResponsibleInfo: (NSArray*) selectedUsersArray;

- (void) returnSelectedClaimingInfo: (NSArray*) selectedClaiming;

- (void) returnSelectedObserversInfo: (NSArray*) selectedObservers;

@end
