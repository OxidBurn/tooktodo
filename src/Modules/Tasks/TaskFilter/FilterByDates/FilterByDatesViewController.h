//
//  FilterByDatesViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 03.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController.h"

// Classes
#import "ProjectsEnumerations.h"
#import "TaskFilterConfiguration.h"

@interface FilterByDatesViewController : BaseMainViewController

// methods
- (void) fillControllerType: (FilterByDateViewControllerType) controllerType
           withFilterConfig: (TaskFilterConfiguration*)       filterConfig;

@end
