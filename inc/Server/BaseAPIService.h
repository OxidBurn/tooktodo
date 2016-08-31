//
//  BaseAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "RACAFNetworking.h"
#import "ReactiveCocoa.h"

// Classes
#import "APIConstance.h"
#import "KeyChainManager.h"

@interface BaseAPIService : NSObject

// properties

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestManager;

@property (strong, nonatomic) AFHTTPRequestOperationManager* requestManagerWithoutContentType;


// methods

- (NSURL*) getRegisterURL;

@end
