//
//  ProjectSystemsObject.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectSystemsModel.h"

@implementation ProjectSystemsModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id": @"systemID"}];
}

@end
