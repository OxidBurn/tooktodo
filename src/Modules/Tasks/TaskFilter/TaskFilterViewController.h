//
//  TaskFilterViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "BaseMainViewController.h"

#import "TaskFilterViewControllerDelegate.h"
#import "ProjectsEnumerations.h"

@protocol TaskFilterViewControllerDelegate;

@interface TaskFilterViewController: BaseMainViewController

// methods
- (void) fillFilterType: (TasksFilterType)                      filterType
           withDelegate: (id<TaskFilterViewControllerDelegate>) delegate;

@end
