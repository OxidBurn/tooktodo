//
//  LoginService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/11/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <AFNetworking-RACExtensions/RACAFNetworking.h>

// Classes
#import "LoginService.h"
#import "APIConstance.h"
#import "KeyChainManager.h"

@implementation LoginService

+ (RACSignal*) sendRequestWithCredentials: (NSString*) email
                             withPassword: (NSString*) password
{
    NSDictionary* parameters = @{@"grant_type" : @"password",
                                 @"username"   : email,
                                 @"password"   : password};
    
    return [LoginService getUserToken: parameters];
}

+ (RACSignal*) getUserToken: (NSDictionary*) requestParameters
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return [[[manager rac_POST: loginURL parameters: requestParameters] logError] replayLazily];
}

+ (RACSignal*) getUserInfo
{
    AFHTTPRequestOperationManager* manager = [LoginService getRequestManager];
    
    return [[[manager rac_GET: userInfoURL parameters: nil] logError] replayLazily];
}

+ (NSURL*) getRegisterURL
{
    NSURL* registerURL = [NSURL URLWithString: registerPageURL];
    
    return registerURL;
}

+ (RACSignal*) sendResetPasswordRequest: (NSString*) email
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary* parameters = @{@"email" : email};
    
    return [[[manager rac_POST: restorePassURL parameters: parameters] logError] replayLazily];
}

+ (RACSignal*) updatePasswordFromOld: (NSString*) old
                               toNew: (NSString*) pass
{
    AFHTTPRequestOperationManager* manager = [LoginService getRequestManager];
    
    NSDictionary* parameters = @{@"oldPassword"     : old,
                                 @"newPassword"     : pass,
                                 @"confirmPassword" : pass};
    
    return [[[manager rac_POST: updatePasswordURL parameters: parameters] logError] replayLazily];
}

+ (RACSignal*) logout
{
    AFHTTPRequestOperationManager* manager = [LoginService getRequestManager];
    
    return [[[manager rac_POST: logoutURL parameters: @{}] logError] replayLazily];
}

+ (RACSignal*) updateUserInfo: (NSDictionary*) newInfo
{
    AFHTTPRequestOperationManager* manager = [LoginService getRequestManager];
    
    return [[[manager rac_PUT: updateUserInfoURL parameters: newInfo] logError] replayLazily];
}


#pragma mark - Internal methods -

+ (AFHTTPRequestOperationManager*) getRequestManager
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager.requestSerializer setValue: [NSString stringWithFormat: @"Bearer %@", [KeyChain getAccessToken]]
                     forHTTPHeaderField: @"Authorization"];
    [manager.requestSerializer setValue: @"application/json"
                     forHTTPHeaderField: @"Content-Type"];
    
    return manager;
}

@end
