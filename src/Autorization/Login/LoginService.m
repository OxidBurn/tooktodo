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

@implementation LoginService

+ (RACSignal*) sendRequestWithCredentials: (NSString*) email
                             withPassword: (NSString*) password
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];

    manager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    NSDictionary* parameters = @{@"grant_type" : @"password",
                                 @"username"   : email,
                                 @"password"   : password};
    
    return [[[manager rac_POST: loginURL parameters: parameters] logError] replayLazily];
}

+ (NSURL*) getRegisterURL
{
    NSURL* registerURL = [NSURL URLWithString: registerPageURL];
    
    return registerURL;
}

+ (RACSignal*) sendResetPasswordRequest: (NSString*) email
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    return [[[manager rac_POST: loginURL parameters: nil] logError] replayLazily];
}

@end
