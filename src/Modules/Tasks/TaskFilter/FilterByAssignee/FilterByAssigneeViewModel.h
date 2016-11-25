//
//  FilterByAssigneeViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 24.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "FilterByAssigneeModel.h"

@interface FilterByAssigneeViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties
@property (nonatomic, copy) void(^reloadTableView)();

// methods
- (void) fillSelectedUsersInfo: (NSArray*) selectedUsers;

- (void) fillFilterType: (FilterByAssigneeType) filterType;

- (void) selectAll;

- (void) deselectAll;

- (void) saveSelectedAssignees;

@end