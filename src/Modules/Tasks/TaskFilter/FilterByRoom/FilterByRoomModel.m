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
//        _roomsArray = [DataManagerShared ]
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


@end
