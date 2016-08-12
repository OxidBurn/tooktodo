//
//  RecoveryModel.m
//  TookTODO
//
//  Created by Глеб on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "RecoveryModel.h"
#import "LoginService.h"

// Frameworks
#import "NSString+Utils.h"

@implementation RecoveryModel

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

- (RACSignal*) sendRequestForResetingPassword: (NSString*) email
{
    return [LoginService sendResetPasswordRequest: email];
}

- (RACSignal*) openRegistrationPage
{
    return [RACSignal createSignal: ^RACDisposable*(id<RACSubscriber> subscriber) {
        
        [[UIApplication sharedApplication] openURL: [LoginService getRegisterURL]];
        
        [subscriber sendCompleted];
        
        return nil;
        
    }];
}

- (NSString*) getDefaultSuccessRecoveryMessage
{
    return @"Инструкция по восстановлению пароля отправлена на ";
}

@end
