//
//  ProjectRoleTypeModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/19/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectRoleTypeModel.h"

@implementation ProjectRoleTypeModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id" : @"roleTypeID"}];
}

@end
