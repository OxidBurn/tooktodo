//
//  SelectStageModel.m
//  TookTODO
//
// Created by Nikolay Chaban on 30.09.16.
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
    return self.stagesArray.count + 1;
    
}

- (NSArray*) getStages
{
    return [self stagesArray];
}

- (void) handleCheckmarkForIndexPath: (NSIndexPath*) indexPath
{
    if (indexPath.row == 0)
    {
        self.selectedStage.isSelected = @(NO);
        self.selectedStage = nil;
    }
    
    else
    {
        self.selectedStage = self.stagesArray[indexPath.row - 1];
        
        if ([indexPath compare: self.lastIndexPath] != NSOrderedSame)
        {
            self.selectedStage.isSelected = @(YES);
        }
        else
            self.selectedStage.isSelected = @(NO);
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

- (void) fillSelectedStage: (ProjectTaskStage*) stage
{
    self.selectedStage = stage;
    
    NSUInteger indexOfSelectedStage = [self.stagesArray indexOfObject: stage];
    
    self.lastIndexPath = [NSIndexPath indexPathForRow: indexOfSelectedStage + 1
                                            inSection: 0];
}

- (BOOL) isStageSelected: (ProjectTaskStage*) stage
{
    return [self.selectedStage isEqual: stage];
}

@end
