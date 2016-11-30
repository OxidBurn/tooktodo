//
//  FilterByStatusViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

@interface FilterByStatusViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties
@property (nonatomic, copy) void(^reloadTableView)();

// methods
- (NSArray*) getSelectedStatusesArray;

- (void) selectAll;

- (void) deselectAll;

- (void) fillSelectedStatuses: (NSArray*) statuses;

- (BOOL) checkIfAllSelected;

@end
