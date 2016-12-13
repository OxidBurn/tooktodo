//
//  FilterByRoomModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TaskFilterConfiguration.h"
#import "ProjectTaskRoom+CoreDataClass.h"

@interface FilterByRoomModel : NSObject

- (NSArray*) getSelectedRooms;

- (NSArray*) getSelectedRoomIndexes;

- (void) handleRoomSelectionForIndexPath: (NSIndexPath*) indexPath;

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath;

- (void) selectAll;

- (void) deselectAll;

- (void) fillSelectedRoomsInfoFromConfig: (TaskFilterConfiguration*) filterConfig;

- (ProjectTaskRoom*) getRoomForIndexPath: (NSIndexPath*) indexPath;

- (NSUInteger) getNumberOfRows;

- (NSString*) getRoomTitleForIndexPath: (NSIndexPath*) indexPath;

@end
