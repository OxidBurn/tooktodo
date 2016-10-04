//
//  SelectRoomModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectRoomModel.h"

#import "ProjectInfo+CoreDataClass.h"
#import "DataManager+ProjectInfo.h"
#import "ProjectTaskStage+CoreDataClass.h"
#import "ProjectTask+CoreDataClass.h"
#import "DataManager+Tasks.h"

static NSString* levelKey = @"LevelKey";
static NSString* roomKey  = @"RoomKey";

@interface SelectRoomModel()

// properties
@property (nonatomic, strong) NSArray* levelsArray;

// methods


@end

@implementation SelectRoomModel


- (NSArray*) levelsArray
{
    if (_levelsArray == nil)
    {
        _levelsArray = @[@"Level 1", @"Level 2", @"Level 3", @"Level 4", @"Level 5", @"Level 6"];
    }
    
    return _levelsArray;
}

#pragma mark - Public -

- (void) markLevelAsExpandedAtIndexPath: (NSInteger) section
{
    ProjectInfo* proj = [DataManagerShared getSelectedProjectInfo];
    
    ProjectTaskStage* stage = (ProjectTaskStage*)proj.stage.allObjects[section];
    
    __weak typeof(self) blockSelf = self;
    
    [DataManagerShared updateExpandedStateOfStage: stage
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       [blockSelf updateData];
                                       
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

- (ProjectTaskStage*) getStageForSection: (NSUInteger) section
{
    return self.levelsArray[section][levelKey];
}

#pragma mark - Internal -

- (void) updateData
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    __block NSMutableArray* tmpStageInfo = [NSMutableArray array];
    __block NSMutableArray* tmpRowsInfo  = [NSMutableArray array];
    
    [project.stage enumerateObjectsUsingBlock: ^(ProjectTaskStage * _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSMutableDictionary* levelsInfoDic = [NSMutableDictionary dictionaryWithDictionary: @{levelKey : obj}];
        
        
        if ( obj.isExpanded.boolValue )
        {
            [obj.tasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull obj, BOOL * _Nonnull stop) {
                
                [tmpRowsInfo addObject: obj];
                
            }];
        }
        
        if ( tmpRowsInfo.count > 0 )
        {
            [levelsInfoDic setObject: tmpRowsInfo.copy
                              forKey: roomKey];
            
            [tmpRowsInfo removeAllObjects];
        }
        
        [tmpStageInfo addObject: levelsInfoDic];
        
    }];
    
    
    self.levelsArray = tmpStageInfo.copy;
    
    tmpRowsInfo  = nil;
    tmpStageInfo = nil;
}

@end
