//
//  LevelContent.m
//  TookTODO
//
//  Created by Nikolay Chaban on 29.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LevelContent.h"

// Classes
#import "RoomContent.h"
#import "ProjectTaskRoom+CoreDataClass.h"

@implementation LevelContent


#pragma mark - Properties -

- (NSNumber*) numberOfRowsInContent
{
    if ( self.isExpanded )
    {
        _numberOfRowsInContent = @(self.rooms.count);
    }
    else
        _numberOfRowsInContent = @(0);
    
    return _numberOfRowsInContent;
}


#pragma mark - Public -

- (void) fillLevelContent: (ProjectTaskRoomLevel*) roomLevel
{
    self.isSelected  = roomLevel.isSelected;
    self.isExpanded  = roomLevel.isExpanded;
    
    self.levelId     = roomLevel.roomLevelID;
    
    self.levelNumber = roomLevel.level;
    
    self.rooms = [self fillRoomsInfo: roomLevel.rooms.allObjects];
}

- (void) handleSectionSelection
{    
    [self.rooms enumerateObjectsUsingBlock: ^(RoomContent* room, NSUInteger idx, BOOL * _Nonnull stop) {
        
        room.isSelected = self.isSelected;
    }];
}


#pragma mark - Internal -

- (NSArray*) fillRoomsInfo: (NSArray*) roomsInfo
{
    __block NSMutableArray* tmpRoomsArray = [NSMutableArray new];
    
    [roomsInfo enumerateObjectsUsingBlock: ^(ProjectTaskRoom* room, NSUInteger idx, BOOL * _Nonnull stop) {
       
        RoomContent* roomContent = [RoomContent new];
        
        [roomContent fillRoomWithInfo: room];
        
        [tmpRoomsArray addObject: roomContent];
    }];
    
    return tmpRoomsArray.copy;
}


@end
