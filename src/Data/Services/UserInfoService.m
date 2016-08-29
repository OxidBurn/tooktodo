//
//  UserInfoService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserInfoService.h"

// Classes
#import "UserAPIService.h"

@implementation UserInfoService

static dispatch_once_t onceToken;
static UserInfoService* SINGLETON = nil;
static bool isFirstAccess = YES;

#pragma mark - Public Method -

+ (instancetype) sharedInstance
{
    dispatch_once(&onceToken, ^{
        
        isFirstAccess = NO;
        SINGLETON     = [[super allocWithZone: NULL] init];
    });
    
    return SINGLETON;
}


#pragma mark - Methods -

- (RACSignal*) logoutUser: (UserInfo*) info
{
    [DataManagerShared deleteCurrentUser: info];
    
    return [[UserAPIService sharedInstance] logOut];
}

- (void) updateInfoForUser: (UserInfo*)        user
               withNewInfo: (UpdatedUserInfo*) newInfo
{
    // Update info localy
    user.fullName          = [newInfo.name stringByAppendingFormat: @" %@", newInfo.surname];
    user.phoneNumber       = newInfo.phoneNumber;
    user.extendPhoneNumber = newInfo.additionalPhoneNumber;
    
    [[DataManager sharedInstance] updateUserInfo: user];
    
    // Update info on server
    NSDictionary* requestParameters = @{@"firstName"             : newInfo.name,
                                        @"lastName"              : newInfo.surname,
                                        @"phoneNumber"           : newInfo.phoneNumber,
                                        @"additionalPhoneNumber" : newInfo.additionalPhoneNumber};
    
    [[[UserAPIService sharedInstance] updateUserInfoOnServer: requestParameters] subscribeNext: ^(RACTuple* x) {
        
        NSLog(@"Server response: %@", x);
        
    }
                                                              error: ^(NSError *error) {
                                                                  
                                                                  NSLog(@"Error with request: %@", error.localizedDescription);
                                                                  
                                                              }
                                                          completed: ^{
                                                              
                                                              NSLog(@"Success complete");
                                                              
                                                          }];
}

- (RACSignal*) getUserInfo
{
    return [[UserAPIService sharedInstance] getUserInfo];
}


#pragma mark - Life Cycle -

+ (instancetype) allocWithZone: (NSZone*) zone
{
    return [self sharedInstance];
}

+ (instancetype) copyWithZone: (struct _NSZone*) zone
{
    return [self sharedInstance];
}

+ (instancetype) mutableCopyWithZone: (struct _NSZone*) zone
{
    return [self sharedInstance];
}

- (instancetype) copy
{
    return [[UserInfoService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[UserInfoService alloc] init];
}

- (instancetype) init
{
    if( SINGLETON )
    {
        return SINGLETON;
    }
    
    if ( isFirstAccess )
    {
        [self doesNotRecognizeSelector: _cmd];
    }
    
    self = [super init];
    
    return self;
}


@end