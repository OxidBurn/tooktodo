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

@interface TaskFilterViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// properties
@property (nonatomic, copy) void(^showFilterByTermsWithType)(FilterByDateViewControllerType controllerType);

@property (nonatomic, copy) void(^showFilterByAssigneeWithType)(FilterByAssigneeType filterType, NSString* segueId);

// methods
- (void) fillFilterType: (TasksFilterType) filterType;

// helpers for test
- (TaskFilterConfiguration*) getFilterConfig;

@end
