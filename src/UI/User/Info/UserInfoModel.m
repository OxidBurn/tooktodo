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
#import "LoginService.h"
#import "KeyChainManager.h"

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
        UIImage* avatarImage = [UIImage imageWithContentsOfFile: [self getAvatarImagePath]];
        
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
    
    if ( [self getUserEmail] )
    {
        [userInfo addObject: [self getUserEmail]];
    }
    
    return userInfo.copy;
}

- (RACSignal*) logoutUser
{
    [DataManagerShared deleteCurrentUser: self.currentUserInfo];
    
    return [LoginService logout];
}

- (void) saveNewAvatar: (UIImage*) image
{
    NSData* imageData = UIImagePNGRepresentation(image);
    
    [imageData writeToFile: [self getAvatarImagePath]
                atomically: YES];
}


#pragma mark - Internal methods -

- (NSString*) getAvatarImagePath
{
    if ( self.currentUserInfo )
    {
        NSString* filePath = [[Utils getAvatarsDirectoryPath] stringByAppendingString: self.currentUserInfo.photoImagePath];
        
        return filePath;
    }
    
    return nil;
}

@end