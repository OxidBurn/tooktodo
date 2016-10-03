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

@property (nonatomic, assign) BOOL isFirstTime;

@end

@implementation SelectStageModel

#pragma mark - Properties-

- (NSArray*) stagesArray
{
    if (_stagesArray == nil)
    {
         self.isFirstTime = YES;
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
    
    if ([indexPath compare: self.lastIndexPath] == NSOrderedSame)
        
        {
            [self.stagesArray enumerateObjectsUsingBlock: ^(ProjectTaskStage* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                obj.isSelected = @(0);
                
                if ( idx == indexPath.row )
                {
                    obj.isSelected = @(1);
                }
            }];
            
            if (indexPath.row == 0)
            {
                self.selectedStage = nil;
            }
            else
                self.selectedStage = self.stagesArray[indexPath.row - 1];
            
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

@end
