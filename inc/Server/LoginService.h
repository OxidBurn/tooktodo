//
//  LoginService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/11/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface LoginService : NSObject

+ (RACSignal*) sendRequestWithCredentials: (NSString*) email
                             withPassword: (NSString*) password;

+ (NSURL*) getRegisterURL;

+ (RACSignal*) sendResetPasswordRequest: (NSString*) email;

@end
