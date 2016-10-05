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
    
    [DataManagerShared updateExpandedStateOfLevel: level
                                   withCompletion: ^(BOOL isSuccess) {
                                       [blockSelf updateData];
                                       
                                       if (completion)
                                       {
                                           completion (YES);
                                       }
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

- (id) getInfoForCellAtIndexPath: (NSIndexPath*) path
{
    NSArray* cellsContentInfo  = self.levelsArray[path.section][roomKey];
    ProjectTaskRoom* cellInfo  = cellsContentInfo[path.row];
    
    return cellInfo.title;
}

- (BOOL) isSelectedRoomAtIndexPath: (NSIndexPath*) indexPath
{
    ProjectTaskRoomLevel* level = [self getLevelForSection: indexPath.section];
    ProjectTaskRoom* room       = level.rooms.allObjects[indexPath.row];
    
    return room.isSelected;
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
            [level.rooms enumerateObjectsUsingBlock:^(ProjectTaskRoom * _Nonnull obj, BOOL * _Nonnull stop) {
                
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

- (void) updateSelectedStateForSection: (NSUInteger) section
{
    self.selectedLevel = [self getLevelForSection: section];
    
    [self.selectedLevel.rooms enumerateObjectsUsingBlock: ^(ProjectTaskRoom * _Nonnull obj, BOOL * _Nonnull stop) {
       
        if ([self.selectedLevel.isSelected isEqual: @(YES)])
        {
            obj.isSelected = @(YES);
        }
        else
        {
            obj.isSelected = @(NO);
        }
<<<<<<< HEAD
        else level.isSelected = @(YES);
        
        self.selectedLevel = level;
        
        [self.selectedLevel.rooms enumerateObjectsUsingBlock:^(ProjectTaskRoom * _Nonnull obj, BOOL * _Nonnull stop) {
            
            if ([self.selectedLevel.isSelected isEqual: @(YES)])
            {
                obj.isSelected = @(YES);
                self.selectedRoom = obj;
            }
            else
            {
                obj.isSelected = @(NO);
                self.selectedRoom = obj;
            }
            
            NSLog(@"  %@", obj.isSelected);
        }];
        
        
=======
>>>>>>> bec05c7a7e8d45e182dd07b0e638f7fd8ddcd66a
        
    }];
}

- (void) handleCheckmarkForSection: (NSUInteger) section
                    withCompletion: (CompletionWithSuccess) completion
{
    __weak typeof(self) blockSelf = self;
    
    [DataManagerShared updateSelectedStateOfLevel: self.selectedLevel
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       [blockSelf updateSelectedStateForSection: section];
                                       
                                       if (completion)
                                       {
                                           completion (YES);
                                       }
                                   }];
}

- (void) handleCheckmarkForRow: (NSUInteger) row
{
    
}

@end
