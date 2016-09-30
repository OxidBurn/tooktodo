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
    return self.stagesArray.count;
}

- (NSArray*) getStages
{
    return self.stagesArray;
}
@end
