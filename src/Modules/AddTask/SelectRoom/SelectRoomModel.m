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

static NSString* levelKey = @"LevelKey";
static NSString* roomKey  = @"RoomKey";

@interface SelectRoomModel()

// properties
@property (nonatomic, strong) NSArray* levelsArray;

@property (nonatomic, strong) ProjectTaskRoomLevel* level;

// methods


@end

@implementation SelectRoomModel

- (NSArray*) levelsArray
{
    if (_levelsArray == nil)
    {
        _levelsArray = [DataManagerShared getAllRoomsLevelOfSelectedProject];
    }
    return  _levelsArray;
}

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

- (void) markLevelAsExpandedAtIndexPath: (NSInteger) section
                         withCompletion: (CompletionWithSuccess) completion
{
   
    ProjectTaskRoomLevel* level = (ProjectTaskRoomLevel*)self.levelsArray[section];
    
    __weak typeof(self) blockSelf = self;
    
    [DataManagerShared updateExpandedStateOfLevel: level
                                   withCompletion: ^(BOOL isSuccess) {
                                       [blockSelf updateData];
                                   }];
    if (completion) {
        
    }

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
    NSArray* cellsContentInfo = self.levelsArray[path.section][roomKey];
    id cellInfo               = cellsContentInfo[path.row];
    
    return cellInfo;
}


#pragma mark - Internal -

- (void) updateData
{
    __block NSMutableArray* tmpLevelInfo = [NSMutableArray array];
    __block NSMutableArray* tmpRowsInfo  = [NSMutableArray array];
    
    [self.levelsArray enumerateObjectsUsingBlock:^(ProjectTaskRoomLevel* _Nonnull level, NSUInteger idx, BOOL * _Nonnull stop) {
       
        NSMutableDictionary* levelsInfoDic = [NSMutableDictionary dictionaryWithDictionary:@{levelKey : level}];
        
        level.isExpanded = @(YES);
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
        
        [tmpLevelInfo addObject: levelsInfoDic];
    }];
    
    
    self.levelsArray = tmpLevelInfo.copy;
    
    tmpRowsInfo  = nil;
    tmpLevelInfo = nil;
}

@end
