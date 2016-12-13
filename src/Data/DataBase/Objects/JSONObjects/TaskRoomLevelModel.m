//
//  TaskRoomLavelModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskRoomLevelModel.h"

@implementation TaskRoomLevelModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id" : @"roomLevelID"}];
}

@end
