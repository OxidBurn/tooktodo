//
//  TaskActionModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskActionModel.h"

@implementation TaskActionModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id"          : @"actionID",
                                                        @"description" : @"actionDescription"}];
}

@end
