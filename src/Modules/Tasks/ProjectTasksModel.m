//
//  ProjectTasksModel.m
//  TookTODO
//
//  Created by Lera on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectTasksModel.h"

// Classes
#import "ProjectTaskStage+CoreDataClass.h"

// Categories
#import "DataManager+ProjectInfo.h"
#import "DataManager+Tasks.h"

static NSString* stageKey   = @"stageInfoKey";
static NSString* contentKey = @"contentInfoKey";

@interface ProjectTasksModel()

// properties

@property (nonatomic, strong) ProjectInfo* currentProjectInfo;

@property (nonatomic, strong) NSArray* stages;

// methods


@end

@implementation ProjectTasksModel

#pragma mark - Public methods -

- (RACSignal*) updateContent
{
    RACSignal* updateInfoSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        [self updateAllTasksData];
        
        [subscriber sendCompleted];
        
        return nil;
    }];
    
    return updateInfoSignal;
}

- (NSUInteger) countOfSections
{
    return self.stages.count;
}


- (NSUInteger) countOfRowsInSection: (NSUInteger) section
{
    NSArray* rowsInfoCount = self.stages[section][contentKey];
    
    return rowsInfoCount.count;
}

- (ProjectTaskStage*) getStageForSection: (NSUInteger) section
{
    return self.stages[section][stageKey];
}

- (void) markStageAsExpandedAtIndexPath: (NSInteger)             section
                         withCompletion: (CompletionWithSuccess) completion
{    
    ProjectTaskStage* stage = (ProjectTaskStage*)self.currentProjectInfo.stage.allObjects[section];
    
    __weak typeof(self) blockSelf = self;
    
    [DataManagerShared updateExpandedStateOfStage: stage
                                   withCompletion: ^(BOOL isSuccess) {
                                       
                                       [blockSelf updateAllTasksData];
                                       
                                       if ( completion )
                                           completion(YES);
                                       
                                   }];
}

- (NSString*) getCellIDAtIndexPath: (NSIndexPath*) path
{
    id cellInfo = [self getInfoForCellAtIndexPath: path];
    
    if ( [cellInfo isKindOfClass: [ProjectTaskStage class]] )
    {
        return @"StageTypeCellID";
    }
    else
    {
        return @"TaskInfoCellID";
    }
    
    return @"";
}

- (id) getInfoForCellAtIndexPath: (NSIndexPath*) path
{
    NSArray* cellsContentInfo = self.stages[path.section][contentKey];
    id cellInfo               = cellsContentInfo[path.row];
    
    return cellInfo;
}


- (CGFloat) getCellHeightAtIndexPath: (NSIndexPath*) path
{
    NSString* cellID = [self getCellIDAtIndexPath: path];
    
    if ( [cellID isEqualToString: @"StageTypeCellID"] )
        return 55.0f;
    else
        return 139.0f;
}




#pragma mark - Internal methods -

- (void) updateAllTasksData
{
    self.currentProjectInfo = [DataManagerShared getSelectedProjectInfo];
    
   // self.stages = self.currentProjectInfo.stage.allObjects;
    
    __block NSMutableArray* tmpStageInfo = [NSMutableArray array];
    __block NSMutableArray* tmpRowsInfo  = [NSMutableArray array];
    
    [self.currentProjectInfo.stage enumerateObjectsUsingBlock: ^(ProjectTaskStage * _Nonnull obj, BOOL * _Nonnull stop) {
        
        NSMutableDictionary* stagesInfoDic = [NSMutableDictionary dictionaryWithDictionary: @{stageKey : obj}];
        
        
         if ( obj.isExpanded.boolValue )
        {
            [obj.tasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull obj, BOOL * _Nonnull stop) {
                
                [tmpRowsInfo addObject: obj];
                        
            }];
        }
        
        if ( tmpRowsInfo.count > 0 )
        {
            [stagesInfoDic setObject: tmpRowsInfo.copy
                              forKey: contentKey];
            
            [tmpRowsInfo removeAllObjects];
        }
        
        [tmpStageInfo addObject: stagesInfoDic];
                
    }];
    
    
    self.stages = tmpStageInfo.copy;
    
    tmpRowsInfo  = nil;
    tmpStageInfo = nil;
}

@end
