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

+ (RACSignal*) getUserInfo;

+ (NSURL*) getRegisterURL;

+ (RACSignal*) sendResetPasswordRequest: (NSString*) email;

+ (RACSignal*) updatePasswordFromOld: (NSString*) old
                               toNew: (NSString*) pass;

+ (RACSignal*) getProjectsList: (NSDictionary*) parameters;

+ (RACSignal*) logout;

+ (RACSignal*) updateUserInfo: (NSDictionary*) newInfo;

@end
