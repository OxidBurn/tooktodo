//
//  FilterByRoomModel.m
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByRoomModel.h"

#import "DataManager+Room.h"
#import "DataManager+Filters.h"

@interface FilterByRoomModel()

// properties
@property (nonatomic, strong) NSArray* roomsArray;

@property (nonatomic, strong) NSArray* selectedRoomsArray;

@property (nonatomic, strong) NSArray* selectedRoomIndexesArray;

// methods


@end

@implementation FilterByRoomModel


#pragma mark - Properties -

- (NSArray*) roomsArray
{
    if (_roomsArray == nil)
    {
        _roomsArray = [DataManagerShared getFilterRoomsForCurrentProject];
    }
    
    return _roomsArray;
}

- (NSArray*) selectedRoomsArray
{
    if (_selectedRoomsArray == nil)
    {
        _selectedRoomsArray = [NSArray array];
    }
    
    return _selectedRoomsArray;
}

- (NSArray*) selectedRoomIndexesArray
{
    if (_selectedRoomIndexesArray == nil)
    {
        _selectedRoomIndexesArray = [NSArray array];
    }
    
    return _selectedRoomIndexesArray;
}

#pragma mark - Public -

- (NSArray*) getSelectedRoomIndexes
{
    return self.selectedRoomIndexesArray;
}

- (NSArray*) getSelectedRooms
{
    return self.selectedRoomsArray;
}

- (void) handleRoomSelectionForIndexPath: (NSIndexPath*) indexPath
{
    // adding to array indexes of selected assignee
    NSMutableArray* tmp = self.selectedRoomIndexesArray.mutableCopy;
    
    NSNumber* index = @(indexPath.row);
    
    if ( [self.selectedRoomIndexesArray containsObject: index] )
    {
        [tmp removeObject: index];
    }
    else
        [tmp addObject: index];
    
    self.selectedRoomIndexesArray = tmp.copy;
    
    // adding to array selected assignees
    NSMutableArray* tmpRooms = self.selectedRoomsArray.mutableCopy;
    
    ProjectTaskRoom* selectedRoom = self.roomsArray[indexPath.row];
    
    if ( [self.selectedRoomsArray containsObject: selectedRoom] )
    {
        [tmpRooms removeObject: selectedRoom];
    }
    else
        [tmpRooms addObject: selectedRoom];
    
    self.selectedRoomsArray = tmpRooms.copy;

}

- (BOOL) getCheckmarkStateForIndexPath: (NSIndexPath*) indexPath
{
    BOOL isSelected;
    
    [self handleRoomSelectionForIndexPath: indexPath];
    
    if ( [self.selectedRoomIndexesArray containsObject: @(indexPath.row)] )
        isSelected = YES;
    
    return isSelected;
}

- (void) selectAll
{
    self.selectedRoomIndexesArray = nil;
    self.selectedRoomsArray       = self.roomsArray;
    
    __block NSMutableArray* tmp = [NSMutableArray new];
    
    [self.roomsArray enumerateObjectsUsingBlock: ^(ProjectTaskRoom* room, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [tmp addObject: @(idx)];
        
    }];
    
    self.selectedRoomIndexesArray = tmp.copy;
}

- (void) deselectAll
{
    self.selectedRoomIndexesArray = nil;
    self.selectedRoomsArray       = nil;
}

- (void) fillSelectedRoomsInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
   
    self.selectedRoomsArray        = filterConfig.byRooms;
    self.selectedRoomIndexesArray  = filterConfig.byRoomIndexes;
    
}

- (ProjectTaskRoom*) getRoomForIndexPath: (NSIndexPath*) indexPath
{
    ProjectTaskRoom* room = self.roomsArray[indexPath.row];
    
    return room;
}

- (NSString*) getRoomTitleForIndexPath: (NSIndexPath*) indexPath
{
    ProjectTaskRoom* room = self.roomsArray[indexPath.row];
    
    return room.title;
}

- (NSUInteger) getNumberOfRows
{
    return self.roomsArray.count;
}

@end
