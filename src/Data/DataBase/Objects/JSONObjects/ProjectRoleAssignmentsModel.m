//
//  ProjectRoleAssignments.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/19/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectRoleAssignmentsModel.h"

@implementation ProjectRoleAssignmentsModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id" : @"roleID"}];
}

@end
