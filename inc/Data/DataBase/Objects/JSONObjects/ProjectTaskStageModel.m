//
//  ProjectTaskStageModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 12/2/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectTaskStageModel.h"

@implementation ProjectTaskStageModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id" : @"stageID"}];
}

@end
