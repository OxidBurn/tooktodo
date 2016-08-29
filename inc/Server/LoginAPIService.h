//
//  LoginAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "BaseAPIService.h"

@interface LoginAPIService : BaseAPIService

/**
 * gets singleton object.
 * @return singleton
 */
+ (LoginAPIService*) sharedInstance;

- (RACSignal*) sendRequestWithCredentials: (NSString*) email
                             withPassword: (NSString*) password;

- (RACSignal*) sendResetPasswordRequest: (NSString*) email;

@end
