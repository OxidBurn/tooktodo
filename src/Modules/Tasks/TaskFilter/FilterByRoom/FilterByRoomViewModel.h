//
//  FilterByRoomViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaskFilterConfiguration.h"

@interface FilterByRoomViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties
@property (nonatomic, copy) void(^reloadTableView)();

//methods

- (NSArray*) getSelectedRooms;

- (NSArray*) getSelectedRoomIndexes;

- (void) selectAll;

- (void) deselectAll;

- (void) fillSelectedRoomsInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

@end
