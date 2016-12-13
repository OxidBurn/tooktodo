//
//  LoginModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface LoginModel : NSObject

// properties


// methods

- (BOOL) isValidEnteredCreadentials: (NSString*) email
                        andPassword: (NSString*) password;

- (NSString*) getWarningMessageForEmail: (NSString*) email;

- (NSString*) getWarningMessageForPassowrd: (NSString*) password;

- (BOOL) isValidEmail: (NSString*) email;

- (RACSignal*) sendRequestWithCredentials: (NSString*) email
                             withPassword: (NSString*) password;

- (RACSignal*) openRegistrationPage;

- (NSString*) getStoredEmailValue;

@end
