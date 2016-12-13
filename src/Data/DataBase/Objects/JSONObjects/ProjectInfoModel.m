//
//  ProjectInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectInfoModel.h"

#import "JSONValueTransformer+CustomDate.h"

@implementation ProjectInfoModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id"        : @"projectID",
                                                        @"lastVisit" : @"lastVisit"}];
}

@end
