//
//  StorageFileAutorModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface StorageFileAutorModel : JSONModel

@property (strong, nonatomic) NSNumber* id;
@property (strong, nonatomic) NSString* email;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* displayName;
@property (nonatomic, strong) NSString* avatarSrc;
@property (nonatomic, strong) NSString* additionalPhoneNumber;
@property (nonatomic, strong) NSString* phoneNumber;
@property (nonatomic, assign) BOOL      isSubscribedOnEmailNotifications;
@property (nonatomic, assign) BOOL      isTourViewed;

@end
