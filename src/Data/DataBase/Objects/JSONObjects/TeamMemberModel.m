//
//  TeamMemberObject.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamMemberModel.h"

@implementation TeamMemberModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id": @"memberID"}];
}

@end
