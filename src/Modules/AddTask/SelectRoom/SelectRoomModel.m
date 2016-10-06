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
    NSArray* arr =  currProj.roomLevel.array;
    
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
    
    //обновление состояния selected в БД
    
    [DataManagerShared updateSelectedStateOfLevel: self.selectedLevel
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       [blockSelf updateSelectedStateForSection: section];
                                      
                                       if (completion)
                                           completion (YES);
                                       
                                   }];
}

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) path
                      withCompletion: (CompletionWithSuccess) completion

{
    __weak typeof(self) blockSelf = self;
    
    [DataManagerShared updateSelectedStateOfRoom: self.selectedRoom
                                  withCompletion: ^(BOOL isSuccess) {
                                      
                                      [blockSelf updateSelectedRoomStateForIndexPath: path];
                                      
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
    self.selectedRoom           = level.rooms.allObjects[indexPath.row];
    
    return self.selectedRoom.isSelected;
}



- (void) resetAllWithCompletion: (CompletionWithSuccess) completion
{
    self.selectedLevel.isSelected = @(NO);
    
    [self.selectedLevel.rooms enumerateObjectsUsingBlock:^(ProjectTaskRoom * _Nonnull obj, BOOL * _Nonnull stop) {
        
        if (self.selectedLevel.isSelected.boolValue == NO)
        {
            obj.isSelected = @(NO);
        }
        
    }];
    
    if (completion)
        completion(YES);
}

- (void) fillSelectedRoom: (id)           selectedRoom
{
    if ([selectedRoom isKindOfClass:[ProjectTaskRoom class]])
    {
//        self.selectedRoom = (ProjectTaskRoom*)selectedRoom;
//        
//        NSUInteger indexOfSelectedRoom = [self.levelsArray indexOfObject: selectedRoom];
//        
//        self.lastIndexPath = [NSIndexPath indexPathForRow: indexOfSelectedRoom
//                                                inSection: 0];
    }
    
    if ([selectedRoom isKindOfClass:[ProjectTaskRoomLevel class]])
    {
        ProjectTaskRoomLevel* selectedLevel = (ProjectTaskRoomLevel*) selectedRoom;
        self.selectedLevel = selectedLevel;
        
        NSArray* levels = [DataManagerShared getAllRoomsLevelOfSelectedProject];
        
        NSUInteger indexOfSelectedRoomLevel = [levels indexOfObject: selectedLevel];
        
        self.lastIndexPath = [NSIndexPath indexPathForRow: indexOfSelectedRoomLevel
                                                inSection: 0];
    }
}

#pragma mark - Internal -

- (void) updateData
{
    __block NSMutableArray* tmpLevelInfo = [NSMutableArray array];
    __block NSMutableArray* tmpRowsInfo  = [NSMutableArray array];
    
    NSArray* levels = [DataManagerShared getAllRoomsLevelOfSelectedProject];
    
    [levels enumerateObjectsUsingBlock:^(ProjectTaskRoomLevel* _Nonnull level, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSMutableDictionary* levelsInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{levelKey : level}];
        
        NSArray* rooms = level.rooms.allObjects;
        
        NSLog(@"rooms %@", rooms);
        
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

//- (void) updateSelectedStateForSection: (NSUInteger) section
//{
//    self.selectedLevel = [self getLevelForSection: section];
//
//    [self.selectedLevel.rooms enumerateObjectsUsingBlock: ^(ProjectTaskRoom * _Nonnull obj, BOOL * _Nonnull stop) {
//        
//        obj.isSelected = @(self.selectedLevel.isSelected.boolValue);
//        
//        NSLog(@"  %@", obj.isSelected);
//    }];
//}

- (void) updateSelectedStateForSection: (NSUInteger) section
{
    NSArray* levels = [DataManagerShared getAllRoomsLevelOfSelectedProject];
    
    [levels enumerateObjectsUsingBlock: ^(ProjectTaskRoomLevel* _Nonnull level, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (idx != section)
        {
            level.isSelected = @(NO);
        }
        else
        {
            level.isSelected = @(YES);
        }
        
        self.selectedLevel = levels[section];
        
        [self.selectedLevel.rooms enumerateObjectsUsingBlock: ^(ProjectTaskRoom * _Nonnull obj, BOOL * _Nonnull stop) {
            
            obj.isSelected = @(self.selectedLevel.isSelected.boolValue);
        }];
        
    }];

}

- (void) updateSelectedRoomStateForIndexPath: (NSIndexPath*) path
{
    ProjectTaskRoom* room = [self getInfoForCellAtIndexPath: path];
    
    if (self.lastIndexPath == path)
    {
        room.isSelected = @(NO);
        self.selectedRoom = room;
        [self updateLastIndexPath: path];
    }
    
    else
    {
        room.isSelected = @(YES);
        self.selectedRoom = room;
        [self updateLastIndexPath: path];
    }

}

@end
