//
//  UserInfo.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface UserInfoData : JSONModel

@property (strong, nonatomic) NSString* userName;
@property (strong, nonatomic) NSString* emailConfirmed;
@property (strong, nonatomic) NSString* role;
@property (assign, nonatomic) NSUInteger userID;
@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* displayName;
@property (strong, nonatomic) NSString* avatarSrc;
@property (strong, nonatomic) NSString<Optional>* additionalPhoneNumber;
@property (strong, nonatomic) NSString<Optional>* phoneNumber;
@property (assign, nonatomic) BOOL isSubscribedOnEmailNotifications;
@property (assign, nonatomic) BOOL isTourViewed;

@end
