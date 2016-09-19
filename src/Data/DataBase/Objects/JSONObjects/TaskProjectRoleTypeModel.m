//
//  TaskProjectRoleTypeModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskProjectRoleTypeModel.h"

@implementation TaskProjectRoleTypeModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id" : @"roleTypeID"}];
}

@end
