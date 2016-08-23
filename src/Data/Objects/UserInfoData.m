//
//  UserInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserInfoData.h"

// Classes
#import "Utils.h"

@implementation UserInfoData

+ (JSONKeyMapper*) keyMapper
{
    return [[JSONKeyMapper alloc] initWithDictionary: @{@"id": @"userID"}];
}

- (void) setLastName: (NSString*) lastName
{
    _lastName = [Utils stringByStrippingHTML: lastName];
}

- (void) setFirstName: (NSString*) firstName
{
    _firstName = [Utils stringByStrippingHTML: firstName];
}

- (void) setDisplayName: (NSString*) displayName
{
    _displayName = [Utils stringByStrippingHTML: displayName];
}

@end
