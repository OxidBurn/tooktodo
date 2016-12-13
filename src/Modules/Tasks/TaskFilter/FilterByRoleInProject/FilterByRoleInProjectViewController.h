//
//  FilterByRoleInProjectViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "BaseMainViewController.h"
#import "TaskFilterConfiguration.h"
#import "ProjectsEnumerations.h"

@protocol FilterByRoleInProjectControllerDelegate;

@interface FilterByRoleInProjectViewController : BaseMainViewController

// properties
@property (nonatomic, weak) id <FilterByRoleInProjectControllerDelegate> delegate;

// methods
- (void) fillSelectedRoleType: (NSNumber*) roleType;

@end

@protocol FilterByRoleInProjectControllerDelegate <NSObject>

- (void) returnSelectedRoleType: (NSNumber*) selectedRoleType;

@end
