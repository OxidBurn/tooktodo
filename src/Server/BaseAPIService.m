//
//  BaseAPIService.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseAPIService.h"

@implementation BaseAPIService

#pragma mark - Public methods -

- (AFHTTPRequestOperationManager*) getRequestManager
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

- (NSURL*) getRegisterURL
{
    NSURL* registerURL = [NSURL URLWithString: registerPageURL];
    
    return registerURL;
}




@end
