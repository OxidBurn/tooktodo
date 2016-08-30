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

- (AFHTTPRequestOperationManager*) requestManager
{
    if ( _requestManager == nil )
    {
        _requestManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL: [NSURL URLWithString: serverURL]];
        
        _requestManager.requestSerializer  = [AFHTTPRequestSerializer serializer];
        _requestManager.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [_requestManager.requestSerializer setValue: [NSString stringWithFormat: @"Bearer %@", [KeyChain getAccessToken]]
                                 forHTTPHeaderField: @"Authorization"];
        [_requestManager.requestSerializer setValue: @"application/json"
                                 forHTTPHeaderField: @"Content-Type"];
    }
    
    return _requestManager;
}

- (AFHTTPRequestOperationManager*) requestManagerWithoutContentType
{
    if ( _requestManagerWithoutContentType == nil )
    {
        _requestManagerWithoutContentType = [[AFHTTPRequestOperationManager alloc] initWithBaseURL: [NSURL URLWithString: serverURL]];
        
        _requestManagerWithoutContentType.requestSerializer  = [AFHTTPRequestSerializer serializer];
        _requestManagerWithoutContentType.responseSerializer = [AFJSONResponseSerializer serializer];
        
        [_requestManagerWithoutContentType.requestSerializer setValue: [NSString stringWithFormat: @"Bearer %@", [KeyChain getAccessToken]]
                                                   forHTTPHeaderField: @"Authorization"];
    }
    
    return _requestManagerWithoutContentType;
}

- (NSURL*) getRegisterURL
{
    NSURL* registerURL = [NSURL URLWithString: registerPageURL];
    
    return registerURL;
}

@end
