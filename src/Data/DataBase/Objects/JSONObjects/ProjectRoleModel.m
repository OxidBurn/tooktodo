//
//  ProjectRoleObject.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectRoleModel.h"

@implementation ProjectRoleModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id" : @"roleID"}];
}

@end
