//
//  UpdateUserInfoModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/18/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UpdateUserInfoModel.h"

// Classes
#import "DataManager+UserInfo.h"
#import "UserInfo.h"
#import "Utils.h"
#import "UserInfoService.h"

@interface UpdateUserInfoModel()

// properties

@property (strong, nonatomic) UserInfo* currentUserInfo;

// methods


@end

@implementation UpdateUserInfoModel

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

- (NSString*) getUserName
{
    NSArray* names = [self.currentUserInfo.fullName componentsSeparatedByString: @" "];
    
    if ( names.count > 0 )
        return names.firstObject;
    
    return @"";
}

- (NSString*) getSurName
{
    NSArray* names = [self.currentUserInfo.fullName componentsSeparatedByString: @" "];
    
    if ( names.count > 1 )
        return names.lastObject;
    
    return @"";
}

- (NSString*) getUserPhoneNumber
{
    return self.currentUserInfo.phoneNumber;
}

- (NSString*) getUserAdditionalPhoneNumber
{
    return self.currentUserInfo.extendPhoneNumber;
}

- (void) updateUserValues: (UpdatedUserInfo*)        newInfo
           withCompletion: (void(^)(BOOL isSuccess)) completion
{
    [[UserInfoService sharedInstance] updateInfoForUser: self.currentUserInfo
                                            withNewInfo: newInfo
                                         withCompletion: completion];
}

@end
