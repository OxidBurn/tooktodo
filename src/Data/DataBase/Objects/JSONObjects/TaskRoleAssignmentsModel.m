//
//  TaskRoleAssignmentsModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskRoleAssignmentsModel.h"

@implementation TaskRoleAssignmentsModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id" : @"roleAssignmentsID"}];
}

@end
