//
//  ProjectTaskObject.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectTaskModel.h"

@implementation ProjectTaskModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id": @"taskID"}];
}

@end
