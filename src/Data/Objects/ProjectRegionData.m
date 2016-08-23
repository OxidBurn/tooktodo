//
//  ProjectRegion.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectRegionData.h"

@implementation ProjectRegionData

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id"    : @"regionID",
                                                        @"value" : @"name"}];
}

@end
