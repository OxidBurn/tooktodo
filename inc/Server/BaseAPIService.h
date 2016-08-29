//
//  BaseAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <AFNetworking-RACExtensions/RACAFNetworking.h>
#import <ReactiveCocoa.h>

// Classes
#import "APIConstance.h"
#import "KeyChainManager.h"

@interface BaseAPIService : NSObject

// properties


// methods

- (AFHTTPRequestOperationManager*) getRequestManager;

- (NSURL*) getRegisterURL;

@end