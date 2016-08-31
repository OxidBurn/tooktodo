//
//  BaseAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseAPIService.h"

@interface BaseAPIService()

// properties


// methods


@end

@implementation BaseAPIService

#pragma mark - Public methods -

- (AFHTTPRequestOperationManager *)getDefaultManager
{
    AFHTTPRequestOperationManager* requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL: [NSURL URLWithString: serverURL]];
    
    requestManager.requestSerializer  = [AFHTTPRequestSerializer serializer];
    requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [requestManager.requestSerializer setValue: [NSString stringWithFormat: @"Bearer %@", [KeyChain getAccessToken]]
                             forHTTPHeaderField: @"Authorization"];
    [requestManager.requestSerializer setValue: @"application/json"
                             forHTTPHeaderField: @"Content-Type"];
    
    return requestManager;
}

- (AFHTTPRequestOperationManager *)getManagerWithToken
{
    AFHTTPRequestOperationManager* requestManagerWithoutContentType = [[AFHTTPRequestOperationManager alloc] initWithBaseURL: [NSURL URLWithString: serverURL]];
    
    requestManagerWithoutContentType.requestSerializer  = [AFHTTPRequestSerializer serializer];
    requestManagerWithoutContentType.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [requestManagerWithoutContentType.requestSerializer setValue: [NSString stringWithFormat: @"Bearer %@", [KeyChain getAccessToken]]
                                              forHTTPHeaderField: @"Authorization"];
    
    return requestManagerWithoutContentType;
}

- (NSURL*) getRegisterURL
{
    NSURL* registerURL = [NSURL URLWithString: registerPageURL];
    
    return registerURL;
}

@end
