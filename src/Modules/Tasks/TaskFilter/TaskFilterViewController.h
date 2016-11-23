//
//  TaskFilterViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "ProjectsEnumerations.h"

#import "BaseMainViewController.h"

@interface TaskFilterViewController: BaseMainViewController

// methods
- (void) fillFilterType: (TasksFilterType) filterType;

@end
