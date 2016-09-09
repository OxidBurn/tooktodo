//
//  DefaultRoleObject.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DefaultRoleModel.h"

@implementation DefaultRoleModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id" : @"roleID"}];
}

@end
