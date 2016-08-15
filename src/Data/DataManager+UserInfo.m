//
//  DataManager+UserInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+UserInfo.h"
#import "UserInfo.h"

// Helpers
#import "AvatarHelper.h"

// Extensions
#import "NSDate+Helper.h"

@implementation DataManager (UserInfo)

- (void) persistUserWithInfo: (NSDictionary*) info
{
    NSString* emailValue = info[@"userName"];
    
    UserInfo* userInfo = [self getUserInfoWithEmail: emailValue];
    
    if ( userInfo )
    {
        userInfo.fullName        = info[@"displayName"];
        userInfo.expireTokenDate = info[@".expires"];
    }
    else
    {
        userInfo = [self insertNewObjectForEntityForName: @"UserInfo"];
        
        userInfo.fullName        = info[@"displayName"];
        userInfo.expireTokenDate = [self getDateFromString: info[@".expires"]];
        userInfo.email           = emailValue;
        userInfo.photoImagePath  = [[AvatarHelper sharedInstance] generateAvatarForName: info[@"displayName"]];
    }
    
    [self saveContext];
}

- (UserInfo*) getUserInfoWithEmail: (NSString*) email
{
    NSArray* users              = [self getAllUserInfo];
    NSPredicate* emailPredicate = [NSPredicate predicateWithFormat: @"email == %@", email];
    NSArray* filteredArr        = [users filteredArrayUsingPredicate: emailPredicate];
    
    return (filteredArr.count > 0) ? filteredArr.firstObject : nil;
}

- (NSArray*) getAllUserInfo
{
    return [self fetchObjectsForEntityForName: @"UserInfo"];
}

- (UserInfo*) getCurrentUserInfo
{
    return [[self getAllUserInfo] firstObject];
}


#pragma mark - Helper methods -

- (NSDate*) getDateFromString: (NSString*) string
{
    NSDate* expareDate = [NSDate dateFromString: string withFormat: @"E, dd MMM yyyy HH:mm:ss zzz"];
    
    return expareDate;
}
@end
