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


static NSString* levelKey = @"LevelKey";
static NSString* roomKey  = @"RoomKey";

@interface SelectRoomModel()

// properties
@property (nonatomic, strong) NSArray*              levelsArray;
@property (nonatomic, strong) NSIndexPath*          lastIndexPath;
@property (nonatomic, strong) ProjectTaskRoomLevel* selectedLevel;
@property (nonatomic, strong) ProjectTaskRoom*      selectedRoom;


// methods

@end

@implementation SelectRoomModel

#pragma mark - Public -

- (NSUInteger) sectionsCount
{
    return self.levelsArray.count;
}

- (NSUInteger) countOfRowsInSection: (NSUInteger) section
{
    NSArray* roomsArray = self.levelsArray[section][roomKey];
    
    return roomsArray.count;
}

- (NSIndexPath*) getLastIndexPath
{
    return self.lastIndexPath;
}

- (void) updateLastIndexPath: (NSIndexPath*) indexPath
{
    self.lastIndexPath = indexPath;
}

- (void) markLevelAsExpandedAtIndexPath: (NSInteger) section
                         withCompletion: (CompletionWithSuccess) completion
{
    
    ProjectInfo* currProj = [DataManagerShared getSelectedProjectInfo];
    NSArray* arr          =  currProj.roomLevel.array;
    
    ProjectTaskRoomLevel* level = (ProjectTaskRoomLevel*)arr[section];
    
    __weak typeof(self) blockSelf = self;
    
    //обновление состояния expanded в БД
    
    [DataManagerShared updateExpandedStateOfLevel: level
                                   withCompletion: ^(BOOL isSuccess) {
                                       [blockSelf updateData];
                                       
                                       if (completion)
                                       {
                                           completion (YES);
                                       }
                                   }];

}

- (void) handleCheckmarkForSection: (NSUInteger) section
                    withCompletion: (CompletionWithSuccess) completion
{
    __weak typeof(self) blockSelf = self;
    
    ProjectTaskRoomLevel* roomLevel = [self getLevelForSection: section];
    
    if ( self.selectedLevel != roomLevel && self.selectedLevel.isSelected.boolValue )
    {
        [DataManagerShared updateSelectedStateOfLevel: self.selectedLevel
                                       withCompletion: nil];
    }
    
    self.selectedLevel = roomLevel;
    
    //обновление состояния selected в БД
    
    [DataManagerShared updateSelectedStateOfLevel: roomLevel
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       [blockSelf updateData];
                                      
                                       if (completion)
                                           completion (YES);
                                       
                                   }];
    
}

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) path
                      withCompletion: (CompletionWithSuccess) completion

{
    __weak typeof(self) blockSelf = self;
    
    ProjectTaskRoom* room = [self getInfoForCellAtIndexPath: path];
    
    if ( self.selectedRoom != room && self.selectedRoom.isSelected.boolValue )
    {
        [DataManagerShared updateSelectedStateOfRoom: self.selectedRoom
                                      withCompletion: nil];
    }
    
    self.selectedRoom = room;
    
    [DataManagerShared updateSelectedStateOfRoom: room
                                  withCompletion: ^(BOOL isSuccess) {
                                      
                                      [blockSelf updateData];
                                      
                                      if (completion)
                                          completion (YES);
                                      
                                  }];
}

- (RACSignal*) updateContent
{
    RACSignal* updateInfoSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [self updateData];
        
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    return updateInfoSignal;
}

- (ProjectTaskRoomLevel*) getLevelForSection: (NSUInteger) section
{
    return self.levelsArray[section][levelKey];
}

- (ProjectTaskRoom*) getInfoForCellAtIndexPath: (NSIndexPath*) path
{
    NSArray* cellsContentInfo  = self.levelsArray[path.section][roomKey];
    ProjectTaskRoom* cellInfo  = cellsContentInfo[path.row];
    
    return cellInfo;
}

- (BOOL) isSelectedRoomAtIndexPath: (NSIndexPath*) indexPath
{
    ProjectTaskRoomLevel* level = [self getLevelForSection: indexPath.section];
    ProjectTaskRoom* room       = level.rooms.allObjects[indexPath.row];
    BOOL isSelected             = room.isSelected.boolValue;
    
    return isSelected;
}



- (void) resetAllWithCompletion: (CompletionWithSuccess) completion
{
    if ( self.selectedLevel.isSelected.boolValue )
    {
        [DataManagerShared updateSelectedStateOfLevel: self.selectedLevel
                                       withCompletion:^(BOOL isSuccess) {
                                           
                                           if (completion)
                                               completion(YES);
                                           
                                       }];
    }
    else
        if ( self.selectedRoom.isSelected.boolValue )
        {
            [DataManagerShared updateSelectedStateOfRoom: self.selectedRoom
                                          withCompletion: ^(BOOL isSuccess) {
                                             
                                              if (completion)
                                                  completion(YES);

                                              
                                          }];
        }
    

}



- (void) fillSelectedRoom: (id) selectedItem
{
    NSArray* levels = [DataManagerShared getAllRoomsLevelOfSelectedProject];
    
    if ([selectedItem isKindOfClass: [ProjectTaskRoom class]])
    {
        ProjectTaskRoom* selectedRoom = (ProjectTaskRoom*) selectedItem;
        
        self.selectedRoom = selectedRoom;
        
        [levels enumerateObjectsUsingBlock: ^(ProjectTaskRoomLevel * _Nonnull level, NSUInteger idx, BOOL * _Nonnull stop) {
        
            [level.rooms enumerateObjectsUsingBlock: ^(ProjectTaskRoom * _Nonnull obj, BOOL * _Nonnull stop) {
                
                if ([obj.roomID isEqual: selectedRoom.roomID])
                {
                    NSUInteger indexOfSelectedRoom  = [level.rooms.allObjects indexOfObject: selectedRoom];
                    
                    self.lastIndexPath = [NSIndexPath indexPathForRow: indexOfSelectedRoom
                                                            inSection: 0];
                }
            
            }];
            
        }];
    }
    else
        if ([selectedItem isKindOfClass: [ProjectTaskRoomLevel class]])
        {
            ProjectTaskRoomLevel* selectedLevel = (ProjectTaskRoomLevel*) selectedItem;
            
            self.selectedLevel = selectedLevel;
            
            [levels enumerateObjectsUsingBlock: ^(ProjectTaskRoomLevel * _Nonnull level, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([level.roomLevelID isEqual: selectedLevel.roomLevelID])
                {
                    NSUInteger indexOfSelectedRoomLevel = [levels indexOfObject: selectedLevel];
                
                    self.lastIndexPath = [NSIndexPath indexPathForRow: indexOfSelectedRoomLevel
                                                        inSection: 0];
                }
                
            }];
        }
}

- (ProjectTaskRoom *) getSelectedRoom
{
    return self.selectedRoom;
}

- (ProjectTaskRoomLevel*) getSelectedLevel
{
    return self.selectedLevel;
}

- (id) getSelectedInfo
{
    if (self.selectedLevel.isSelected.boolValue)
    {
        self.selectedRoom = nil;
        return self.selectedLevel;
        
    }
    
    else if (self.selectedRoom.isSelected.boolValue)
    {
        self.selectedLevel = nil;
        return self.selectedRoom;
    }
    
    else
        return @"Не выбрано";
        
}



#pragma mark - Internal -

- (void) updateData
{
    __block NSMutableArray* tmpLevelInfo = [NSMutableArray array];
    __block NSMutableArray* tmpRowsInfo  = [NSMutableArray array];
    
    NSArray* levels = [DataManagerShared getAllRoomsLevelOfSelectedProject];
    
    [levels enumerateObjectsUsingBlock:^(ProjectTaskRoomLevel* _Nonnull level, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSMutableDictionary* levelsInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{levelKey : level}];
        
        if (level.isExpanded.boolValue)
        {
            [level.rooms enumerateObjectsUsingBlock: ^(ProjectTaskRoom * _Nonnull obj, BOOL * _Nonnull stop) {
               
                [tmpRowsInfo addObject: obj];
            
            }];
        }
        
     
        if (tmpRowsInfo.count > 0)
        {
            [levelsInfoDic setObject: tmpRowsInfo.copy
                              forKey: roomKey];
            
            [tmpRowsInfo removeAllObjects];
        }
        
        if (levels.count == 1)
        {
            level.isExpanded = @(YES);
        }
        
        [tmpLevelInfo addObject: levelsInfoDic];
        
    }];
    
    self.levelsArray = tmpLevelInfo.copy;
    
    tmpRowsInfo  = nil;
    tmpLevelInfo = nil;
}

@end
