//
//  TaskStatusActionModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskStatusActionModel.h"

@implementation TaskStatusActionModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id"          : @"statusActionID",
                                                        @"description" : @"stautsActionDescription"}];
}

@end
