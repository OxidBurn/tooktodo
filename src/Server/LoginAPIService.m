//
//  LoginAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LoginAPIService.h"

@implementation LoginAPIService

static dispatch_once_t onceToken;
static LoginAPIService* SINGLETON = nil;
static bool isFirstAccess         = YES;

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

- (RACSignal*) sendRequestWithCredentials: (NSString*) email
                             withPassword: (NSString*) password
{
    NSDictionary* parameters = @{@"grant_type" : @"password",
                                 @"username"   : email,
                                 @"password"   : password};
    
    return [self getUserToken: parameters];
}

- (RACSignal*) getUserToken: (NSDictionary*) requestParameters
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return [[[manager rac_POST: loginURL parameters: requestParameters] logError] replayLazily];
}

- (RACSignal*) sendResetPasswordRequest: (NSString*) email
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary* parameters = @{@"email" : email};
    
    return [[[manager rac_POST: restorePassURL parameters: parameters] logError] replayLazily];
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
    return [[LoginAPIService alloc] init];
}

- (instancetype) mutableCopy
{
    return [[LoginAPIService alloc] init];
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
