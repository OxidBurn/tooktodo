//
//  SelectStageModel.m
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectStageModel.h"

@interface SelectStageModel()

@property (nonatomic, strong) NSArray* stagesArray;

@end

@implementation SelectStageModel


#pragma mark - Public -

- (NSInteger) countOfRows
{
    return self.stagesArray.count;
}

@end
