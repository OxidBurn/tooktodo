//
//  TasksGroupedByProjects.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/12/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksGroupedByProjects.h"

@implementation ShortProjectInfoModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id"         : @"projectID",
                                                        @"tasks.list" : @"tasks"}];
}

@end

@implementation TasksGroupedByProjects



@end
