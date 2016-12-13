//
//  ProjectCountry.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectCountryModel.h"

@implementation ProjectCountryModel

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id"    : @"countryID",
                                                        @"value" : @"name"}];
}

@end
