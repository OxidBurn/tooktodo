//
//  LoginModel.m
//  TookTODO
//
//  Created by Глеб on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LoginModel.h"
#import "LoginService.h"

// Extensions
#import "NSString+Utils.h"

@implementation LoginModel

#pragma mark - Public methods -

- (BOOL) isValidEnteredCreadentials: (NSString*) email
                        andPassword: (NSString*) password
{
    BOOL isValid = ([email isEmailString] && password.length > 5);
    
    return isValid;
}

- (BOOL) isValidEmail: (NSString*) email
{
    return [email isEmailString];
}

- (NSString*) getWarningMessageForEmail: (NSString*) email
{
    if ( email.length == 0 )
        return @"Пожалуйста, укажите эл. почту";
    else
        if ( [email isEmailString] == NO )
        {
            return @"Адрес введен не верно";
        }
    
    return @"";
}

- (NSString*) getWarningMessageForPassowrd: (NSString*) password
{
    if ( password.length == 0 )
    {
        return @"Пожалуйста, укажите пароль для входа в систему";
    }
    else
        if ( password.length < 6 )
        {
            return @"Пароль должен содержать не менее 6 символов";
        }
    
    return @"";
}

- (RACSignal*) sendRequestWithCredentials: (NSString*) email
                             withPassword: (NSString*) password
{
    return [LoginService sendRequestWithCredentials: email
                                       withPassword: password];
}

- (RACSignal*) openRegistrationPage
{
    return [RACSignal createSignal: ^RACDisposable*(id<RACSubscriber> subscriber) {
        
        [[UIApplication sharedApplication] openURL: [LoginService getRegisterURL]];
        
        [subscriber sendCompleted];
        
        return nil;
        
    }];
}

@end
