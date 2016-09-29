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
                 withDelegate: (id)                      delegate;


@end

@protocol SelectResponsibleViewControllerDelegate <NSObject>

- (void) returnSelectedResponsibleInfo: (NSArray*) selectedUsersArray;

@end
