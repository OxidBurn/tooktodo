//
//  TaskSortedByProjectModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskSortedByProjectModel.h"

@implementation TaskSortedByProjectModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id": @"taskID",
                                                        @"description" : @"taskDescription"}];
}

@end
