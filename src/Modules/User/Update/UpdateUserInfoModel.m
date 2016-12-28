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
    return self.currentUserInfo.firstName;
}

- (NSString*) getSurName
{
    return self.currentUserInfo.lastName;
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
    
    if ( [self isEqualNewInfoWithOld: newInfo])
    {
        if ( completion )
            completion(YES);
    }
    else
    {
        [[UserInfoService sharedInstance] updateInfoForUser: self.currentUserInfo
                                                withNewInfo: newInfo
                                             withCompletion: completion];
    }
    
}

- (NSString*) getPhoneNumberFormatString
{
    return @"+*(***)***-**-**";
}

- (AKNumericFormatter*) getPhoneNumberFormat
{
    return [AKNumericFormatter formatterWithMask: [self getPhoneNumberFormatString]
                            placeholderCharacter: '*'];
}

#pragma mark - Internal methods -

- (BOOL) isEqualNewInfoWithOld: (UpdatedUserInfo*) newInfo
{
    BOOL isEqual = NO;
    
    if ( [self.currentUserInfo.firstName isEqualToString: newInfo.name] &&
         [self.currentUserInfo.lastName isEqualToString: newInfo.surname] &&
         [self.currentUserInfo.phoneNumber isEqualToString: newInfo.phoneNumber] &&
         [self.currentUserInfo.extendPhoneNumber isEqualToString: newInfo.additionalPhoneNumber] )
    {
        isEqual = YES;
    }
    
    return isEqual;
}

@end
