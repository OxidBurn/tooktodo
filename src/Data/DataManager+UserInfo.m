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
        userInfo.fullName                         = info[@"displayName"];
        userInfo.firstName                        = info[@"firstName"];
        userInfo.lastName                         = info[@"lastName"];
        userInfo.avatarSrc                        = info[@"avatarSrc"];
        userInfo.userID                           = info[@"id"];
        userInfo.isSubscribedOnEmailNotifications = info[@"isSubscribedOnEmailNotifications"];
        userInfo.expireTokenDate                  = [self getDateFromString: info[@".expires"]];
        userInfo.phoneNumber                      = info[@"phoneNumber"];
        userInfo.extendPhoneNumber                = info[@"additionalPhoneNumber"];
    }
    else
    {
        userInfo = [self insertNewObjectForEntityForName: @"UserInfo"];
        
        userInfo.fullName                         = info[@"displayName"];
        userInfo.expireTokenDate                  = [self getDateFromString: info[@".expires"]];
        userInfo.email                            = emailValue;
        userInfo.firstName                        = info[@"firstName"];
        userInfo.lastName                         = info[@"lastName"];
        userInfo.avatarSrc                        = info[@"avatarSrc"];
        userInfo.userID                           = info[@"id"];
        userInfo.isSubscribedOnEmailNotifications = info[@"isSubscribedOnEmailNotifications"];
        
        if ( info[@"phoneNumber"] )
        userInfo.phoneNumber = info[@"phoneNumber"];
        
        if ( [info[@"additionalPhoneNumber"] isKindOfClass: [NSNull class]] == NO )
            userInfo.extendPhoneNumber = info[@"additionalPhoneNumber"];
        
        userInfo.photoImagePath = [[AvatarHelper sharedInstance] generateAvatarForName: emailValue withAbbreviation: [NSString stringWithFormat: @"%c%c", [userInfo.firstName characterAtIndex: 0], [userInfo.lastName characterAtIndex: 0]]];
    }
    
    [[AvatarHelper sharedInstance] loadAvatarFromWeb: userInfo.avatarSrc
                                            withName: emailValue];
    
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

- (void) updateUserInfo: (UserInfo*) info
{
    [self saveContext];
}

- (void) deleteCurrentUser: (UserInfo*) info
{
    [self removeObject: info];
    
    [self saveContext];
}


#pragma mark - Helper methods -

- (NSDate*) getDateFromString: (NSString*) string
{
    NSDate* expareDate = [NSDate dateFromString: string withFormat: @"E, dd MMM yyyy HH:mm:ss zzz"];
    
    return expareDate;
}
@end
