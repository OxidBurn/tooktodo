//
//  FilterForResponsibleViewController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "ProjectsEnumerations.h"

@protocol SelectResponsibleViewControllerDelegate;

@interface SelectResponsibleViewController : UIViewController

// properties
@property (weak, nonatomic) id <SelectResponsibleViewControllerDelegate> delegate;

// methods
- (void) updateControllerType: (ControllerTypeSelection) controllerType
                  withMembers: (NSArray*)                allMembers
                 withDelegate: (id)                      delegate;

- (void) fillSelectedUsersInfo: (NSArray*) selectedUsers;


@end

@protocol SelectResponsibleViewControllerDelegate <NSObject>

- (void) returnSelectedResponsibleInfo: (NSArray*) selectedUsersArray
                        withAllMembers: (NSArray*) allMembers;

- (void) returnSelectedClaimingInfo: (NSArray*) selectedClaiming
                     withAllMembers: (NSArray*) allMembers;

- (void) returnSelectedObserversInfo: (NSArray*) selectedObservers
                      withAllMembers: (NSArray*) allMembers;

@end
