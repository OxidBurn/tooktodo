//
//  FilterByRoomViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController.h"
#import "TaskFilterConfiguration.h"

@protocol FilterByRoomViewControllerDelegate;

@interface FilterByRoomViewController : BaseMainViewController

@property (nonatomic, weak) id <FilterByRoomViewControllerDelegate> delegate;

- (void) fillSelectedRoomsInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

@end

@protocol FilterByRoomViewControllerDelegate <NSObject>

- (void) returnSelectedRoomsArray: (NSArray*) selectedRooms
                      withIndexes: (NSArray*) indexesArray;

@end
