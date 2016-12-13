//
//  TaskStagesActionModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskStagesActionModel.h"

@implementation TaskStagesActionModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id" : @"stageActionID"}];
}

@end
