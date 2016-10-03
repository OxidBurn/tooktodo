//
//  SelectStageModel.m
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectStageModel.h"

//Classes
#import "DataManager+Tasks.h"

@interface SelectStageModel()

@property (nonatomic, strong) NSArray* stagesArray;

@property (nonatomic, strong) NSIndexPath* lastIndexPath;

@property (nonatomic, strong) ProjectTaskStage* selectedStage;

@end

@implementation SelectStageModel

#pragma mark - Properties-

- (NSArray*) stagesArray
{
    if (_stagesArray == nil)
    {
        _stagesArray = [DataManagerShared getStagesForCurrentProject];
    }
    
    return _stagesArray;
}

#pragma mark - Public -

- (NSInteger) countOfRows
{
    return [self stagesArrayWithNoSelected].count;
    
//    return self.stagesArray.count;
}

- (NSArray*) getStages
{
    return [self stagesArrayWithNoSelected];
}

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath
{
    if ( [indexPath isEqual: self.lastIndexPath] == NO )
    {
        [self.stagesArray enumerateObjectsUsingBlock: ^(ProjectTaskStage* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            obj.isSelected = @(0);
            
            if ( idx == indexPath.row )
            {
                obj.isSelected = @(1);
            }
        }];
        
        self.selectedStage = self.stagesArray[indexPath.row];
    }
}

- (BOOL) getStateForStageAtIndex: (NSUInteger) index
{
    ProjectTaskStage* stage = self.stagesArray[index];
    
    return stage.isSelected;
}

- (void) updateLastIndexPath: (NSIndexPath*) indexPath
{
    self.lastIndexPath = indexPath;
}

- (ProjectTaskStage*) getSelectedStage
{
    return self.selectedStage;
}

- (NSIndexPath*) getLastIndexPath
{
    return self.lastIndexPath;
}

- (NSArray*) stagesArrayWithNoSelected
{
    NSMutableArray* arr = self.stagesArray.mutableCopy;
    [arr insertObject: @"Not selected"
              atIndex: 0];
    
    return arr.copy;
}

@end
