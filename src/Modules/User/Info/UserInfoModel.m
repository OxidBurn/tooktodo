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
#import "UserInfoService.h"
#import "KeyChainManager.h"

@interface UserInfoModel()

// properties

@property (strong, nonatomic) UserInfo* currentUserInfo;

// methods


@end

@implementation UserInfoModel

#pragma mark - Properties -

- (UserInfo*) currentUserInfo
{
    if ( _currentUserInfo == nil )
    {
        _currentUserInfo = [DataManagerShared getCurrentUserInfo];
    }
    
    return _currentUserInfo;
}


#pragma mark - Public -

- (RACSignal*) updateInfo
{
    @weakify(self)
    
    RACSignal* updateUserInfoSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self)
        
        [[RACScheduler mainThreadScheduler] schedule:^{
            
            self.currentUserInfo = [DataManagerShared getCurrentUserInfo];
            
            [subscriber sendNext: nil];
            
        }];
        
        [[[UserInfoService sharedInstance] getNewUserInfo] subscribeNext:^(id x) {
           
            [[RACScheduler mainThreadScheduler] schedule:^{
                
                self.currentUserInfo = [DataManagerShared getCurrentUserInfo];
                
                [subscriber sendNext: nil];
                [subscriber sendCompleted];
                
            }];
            
        }];
        
        return nil;
    }];
    
    return updateUserInfoSignal;
}

- (NSString*) getFullUserName
{
    NSString* fullName = self.currentUserInfo.fullName;
    
    if ( fullName.length > 50 )
        fullName = [fullName substringToIndex: 49];
    
    return fullName;
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

- (NSURL*) getUserAvatarURL
{
    return [NSURL URLWithString: self.currentUserInfo.avatarSrc];
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
    
    if ( [[self getUserPhoneNumber] length] > 0 )
    {
        [userInfo addObject: [self getUserPhoneNumber]];
    }
    
    if ( [[self getUserAdditionalPhoneNumber] length] > 0 )
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
    return [[UserInfoService sharedInstance] logoutUser: self.currentUserInfo];
}

- (void) saveNewAvatar: (UIImage*) image
{
    NSData* imageData = UIImagePNGRepresentation(image);
    
    [imageData writeToFile: [self getAvatarImagePath]
                atomically: YES];
    
    [[UserInfoService sharedInstance] updateAvatarWithFile: [self getAvatarImagePath]];
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
