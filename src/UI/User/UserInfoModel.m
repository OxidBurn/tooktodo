//
//  UserInfoModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserInfoModel.h"

// Classes
#import "DataManager+UserInfo.h"
#import "UserInfo.h"
#import "Utils.h"

@interface UserInfoModel()

// properties

@property (strong, nonatomic) UserInfo* currentUserInfo;

// methods


@end

@implementation UserInfoModel

#pragma mark - Properties -

- (UserInfo *)currentUserInfo
{
    if ( _currentUserInfo == nil )
    {
        _currentUserInfo = [DataManagerShared getCurrentUserInfo];
    }
    
    return _currentUserInfo;
}


#pragma mark - Public -

- (NSString*) getFullUserName
{
    return self.currentUserInfo.fullName;
}

- (UIImage*) getUserAvatarImage
{
    if ( self.currentUserInfo )
    {
        NSString* filePath   = [[Utils getAvatarsDirectoryPath] stringByAppendingString: self.currentUserInfo.photoImagePath];
        UIImage* avatarImage = [UIImage imageWithContentsOfFile: filePath];
        
        return avatarImage;
    }
    
    return [UIImage new];
}

- (NSString*) getUserEmail
{
    return self.currentUserInfo.email;
}

- (NSString*) getUserPhoneNumber
{
    return self.currentUserInfo.phoneNumber;
}

- (NSString*) getUserAdditionalPhoneNumber
{
    return self.currentUserInfo.extendPhoneNumber;
}

- (NSArray*) getUserContactInfo
{
    NSMutableArray* userInfo = [NSMutableArray new];
    
    if ( [self getUserPhoneNumber] )
    {
        [userInfo addObject: [self getUserPhoneNumber]];
    }
    
    if ( [self getUserAdditionalPhoneNumber] )
    {
        [userInfo addObject: [self getUserAdditionalPhoneNumber]];
    }
    
    [userInfo addObject: [self getUserEmail]];
    
    return userInfo.copy;
}

@end
