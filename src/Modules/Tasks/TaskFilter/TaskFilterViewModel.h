//
//  TaskFilterViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "ProjectsEnumerations.h"
#import "TaskFilterConfiguration.h"
#import "AddTaskTypeViewController.h"
#import "SelectSystemViewController.h"
#import "FilterByRoomViewController.h"
#import "FilterByTypesViewController.h"
#import "FilterBySystemsViewController.h"

@interface TaskFilterViewModel : NSObject <UITableViewDataSource, UITableViewDelegate, SelectSystemViewControllerDelegate, FilterByTypesViewControllerDelegate, FilterByRoomViewControllerDelegate, FilterBySystemsViewControllerDelegate>

// properties
@property (nonatomic, copy) void (^showFilterByTermsWithType)(FilterByDateViewControllerType controllerType);

@property (nonatomic, copy) void (^showFilterByAssigneeWithType)(FilterByAssigneeType filterType, NSString* segueId);

@property (nonatomic, copy) void (^showControllerWithSegueId)(NSString* segueId);

@property (nonatomic, copy) void (^reloadTableView)();

// methods
- (void) fillFilterType: (TasksFilterType) filterType;

// helpers for test
- (TaskFilterConfiguration*) getFilterConfig;

- (void) saveFilterConfigurationWithCompletion: (CompletionWithSuccess) completion;

- (void) resetFilterConfigurationForCurrentProject: (CompletionWithSuccess) completion;

@end
