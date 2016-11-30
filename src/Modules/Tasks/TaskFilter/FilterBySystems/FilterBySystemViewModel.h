//
//  FilterBySystemViewModel.h
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TaskFilterConfiguration.h"

@interface FilterBySystemViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// properties
@property (nonatomic, copy) void(^reloadTableView)();

// methods
- (NSArray*) getSelectedSystems;

- (NSArray*) getSelectedSystemsIndexes;

- (void) selectAll;

- (void) deselectAll;

- (void) fillSelectedSystemsInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

- (BOOL) checkIfAllSelected;

@end
