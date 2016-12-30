//
//  SelectRoomModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectRoomModel.h"

#import "ProjectInfo+CoreDataClass.h"
#import "DataManager+Room.h"
#import "ProjectTaskRoomLevel+CoreDataClass.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "DataManager+ProjectInfo.h"

@interface SelectRoomModel()

// properties
@property (strong, nonatomic) NSArray* defaultContentArray;

@end

@implementation SelectRoomModel


#pragma mark - Properties -

- (NSArray*) defaultContentArray
{
    if ( _defaultContentArray == nil )
    {
        _defaultContentArray = [self parseAllLevelsToDefaultContent];
    }
    
    return _defaultContentArray;
}


#pragma mark - Public -


- (LevelContent*) getLevelContentForSection: (NSUInteger) section
{
    return self.defaultContentArray[section];
}

- (RoomContent*) getRoomContentForIndexPath: (NSIndexPath*) indexPath
{
    LevelContent* level = self.defaultContentArray[indexPath.section];
    
    if ( level.isExpanded )
    {
        RoomContent* room = level.rooms[indexPath.row];
        
        return room;
    }
    
    return nil;
}

- (NSUInteger) getNumberOfRowsInSection: (NSUInteger) section
{
    LevelContent* level = self.defaultContentArray[section];
    
    if ( level.isExpanded )
    {
        return level.rooms.count;
    }
    else
        return 0;
}

- (NSUInteger) getNumberOfSections
{
    return self.defaultContentArray.count;
}

- (void) markLevelAsExpandedAtIndexPath: (NSInteger) section
                         withCompletion: (CompletionWithSuccess) completion
{
    LevelContent* level = self.defaultContentArray[section];
    
    level.isExpanded = !level.isExpanded;
    
    [self updateContentWithLevel: level
                       inSection: section];
    
    if ( completion )
        completion(YES);
}

- (void) handleCheckmarkForSection: (NSUInteger) section
                    withCompletion: (CompletionWithSuccess) completion
{
    // method for handling selection of whole section
    // we deselect all level except one that was selected by user
    
    [self.defaultContentArray enumerateObjectsUsingBlock: ^(LevelContent* level, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( idx != section )
        {
            level.isSelected = NO;
            
            [level handleSectionSelection];
        }
        else
        {
            level.isSelected = !level.isSelected;
            
            [level handleSectionSelection];
        }
        
    }];
    
    if ( completion )
        completion (YES);
}

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) path
                      withCompletion: (CompletionWithSuccess) completion

{
    LevelContent* currentLevel = self.defaultContentArray[path.section];
    
    RoomContent* currentRoom = currentLevel.rooms[path.row];
    
    BOOL currentState = currentRoom.isSelected;
    
    if ( currentState == YES && currentLevel.isSelected == NO)
    {
        currentRoom.isSelected = NO;
    }
    else
    {
        [self.defaultContentArray enumerateObjectsUsingBlock: ^(LevelContent* levelContent, NSUInteger idx, BOOL * _Nonnull stop) {
           
            levelContent.isSelected = NO;
            
            [levelContent handleSectionSelection];
            
        }];
        currentRoom.isSelected = YES;
    }
    
    [self updateContentWithRoom: currentRoom
                   forIndexPath: path];
    
    if ( completion )
        completion (YES);
}

- (void) resetAllWithCompletion: (CompletionWithSuccess) completion
{
    [self.defaultContentArray enumerateObjectsUsingBlock: ^(LevelContent* level, NSUInteger idx, BOOL * _Nonnull stop) {
        
        level.isSelected = NO;
        
        [level handleSectionSelection];
    }];
    
    if ( completion )
        completion (YES);
}

- (SelectedRoomsInfo*) getSelectedInfo
{
    __block SelectedRoomsInfo* roomsInfo = [SelectedRoomsInfo new];
    
    [self.defaultContentArray enumerateObjectsUsingBlock: ^(LevelContent* level, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( level.isSelected == YES)
        {
            roomsInfo.idValue = level.levelId;
            
            roomsInfo.roomsType = LevelType;
            
            return;
        }
        
        [level.rooms enumerateObjectsUsingBlock: ^(RoomContent* room, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ( room.isSelected )
            {
                roomsInfo.idValue = room.roomId;
                
                roomsInfo.roomsType = RoomType;
                
                return;
            }
        }];
    }];

    return roomsInfo;
}

- (void) fillSelectedRoomsInfo: (SelectedRoomsInfo*) selectedRooms
{
    [self resetAllWithCompletion: ^(BOOL isSuccess) {
        
        [self.defaultContentArray enumerateObjectsUsingBlock: ^(LevelContent* level, NSUInteger idx, BOOL * _Nonnull stop) {
            
            switch ( selectedRooms.roomsType)
            {
                case LevelType:
                {
                    if ( [level.levelId isEqual: selectedRooms.idValue] )
                    {
                        level.isSelected = YES;
                        
                        [level handleSectionSelection];
                        
                        *stop = YES;
                    }
                }
                    break;
                    
                case RoomType:
                {
                    [level.rooms enumerateObjectsUsingBlock: ^(RoomContent* room, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ( [room.roomId isEqual: selectedRooms.idValue] )
                        {
                            room.isSelected = YES;
                            
                            *stop = YES;
                        }
                    }];
                }
                    break;
                    
                default:
                    break;
            }
        }];
    }];
}


#pragma mark - Internal -

- (NSArray*) parseAllLevelsToDefaultContent
{
    NSArray* allLevels = [DataManagerShared getAllRoomsLevelOfSelectedProject];
    
    __block NSMutableArray* tempContent = [NSMutableArray new];
    
    [allLevels enumerateObjectsUsingBlock: ^(ProjectTaskRoomLevel* level, NSUInteger idx, BOOL * _Nonnull stop) {
        
        LevelContent* lvlContent = [LevelContent new];
        
        [lvlContent fillLevelContent: level];
        
        [tempContent addObject: lvlContent];
    }];
    
    return tempContent.copy;
}

- (void) updateContentWithLevel: (LevelContent*) levelContent
                      inSection: (NSUInteger)    section
{
    NSMutableArray* tmp = self.defaultContentArray.mutableCopy;
    
    [tmp replaceObjectAtIndex: section withObject: levelContent];
    
    self.defaultContentArray = tmp.copy;
}

- (void) updateContentWithRoom: (RoomContent*) roomContent
                  forIndexPath: (NSIndexPath*) indexPath
{
    LevelContent* level = self.defaultContentArray[indexPath.section];
    
    NSMutableArray* tmpRooms = level.rooms.mutableCopy;
    
    [tmpRooms replaceObjectAtIndex: indexPath.row
                        withObject: roomContent];
    
    level.rooms = tmpRooms.copy;
    
    [self updateContentWithLevel: level
                       inSection: indexPath.section];
}

@end
