//
//  DataManager+UserInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+UserInfo.h"
#import "UserInfo.h"

// Frameworks
#import <MagicalRecord/MagicalRecord.h>
#import <MagicalRecord/NSManagedObjectContext+MagicalSaves.h>

// Helpers
#import "AvatarHelper.h"

@implementation DataManager (UserInfo)

- (void) persistUserWithInfo: (UserInfoData*) info
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        UserInfo* userInfo = [self getUserInfoWithEmail: info.email];
        
        if ( userInfo == nil )
        {
            userInfo = [UserInfo MR_createEntityInContext: localContext];
            
            userInfo.photoImagePath = [[AvatarHelper sharedInstance] generateAvatarForName: info.email
                                                                          withAbbreviation: [NSString stringWithFormat: @"%c%c", [userInfo.firstName characterAtIndex: 0], [userInfo.lastName characterAtIndex: 0]]];
        }
        
        userInfo.fullName                         = info.displayName;
        userInfo.email                            = info.email;
        userInfo.firstName                        = info.firstName;
        userInfo.lastName                         = info.lastName;
        userInfo.avatarSrc                        = info.avatarSrc;
        userInfo.userID                           = @(info.userID);
        userInfo.isSubscribedOnEmailNotifications = @(info.isSubscribedOnEmailNotifications);
        userInfo.phoneNumber                      = info.phoneNumber;
        userInfo.extendPhoneNumber                = info.additionalPhoneNumber;
        
        [[AvatarHelper sharedInstance] loadAvatarFromWeb: userInfo.avatarSrc
                                                withName: info.email];
        
    }];
}

- (UserInfo*) getUserInfoWithEmail: (NSString*) email
{
    return [UserInfo MR_findFirstByAttribute: @"email"
                                   withValue: email];
}

- (NSArray*) getAllUserInfo
{
    return [UserInfo MR_findAll];
}

- (UserInfo*) getCurrentUserInfo
{
    return [[self getAllUserInfo] firstObject];
}

- (void) updateUserInfo: (UserInfo*) info
{
    [MagicalRecord saveWithBlockAndWait :^(NSManagedObjectContext * _Nonnull localContext) {
        
    }];
}

- (void) deleteCurrentUser: (UserInfo*) info
{
    [info MR_deleteEntity];
}

@end
