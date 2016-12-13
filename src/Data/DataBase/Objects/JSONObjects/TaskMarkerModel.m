//
//  TaskMarker.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskMarkerModel.h"

@implementation TaskMarkerModel

+ (JSONKeyMapper *)keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id": @"markerID"}];
}

@end
