//
//  LoginModel.m
//  TookTODO
//
//  Created by Глеб on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//


#import "LoginModel.h"
#import "LoginService.h"
#import "KeyChainManager.h"

// Extensions
#import "NSString+Utils.h"
#import "DataManager+UserInfo.h"

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
    @weakify(self)
    
    RACSignal* sendRequestSignal = [RACSignal createSignal: ^RACDisposable*(id<RACSubscriber> subscriber) {
        
        RACSignal* requestSignal = [LoginService sendRequestWithCredentials: email
                                                               withPassword: password];
        
        
        [requestSignal subscribeNext: ^(RACTuple* x) {
            
            @strongify(self)
            
            [self parsingLoginResponseInfo: [x objectAtIndex: 0]];
            
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [subscriber sendNext: [x objectAtIndex: 0]];
                [subscriber sendCompleted];
                
            });
            
        }
                                   error: ^(NSError* error) {
                                       
                                       [subscriber sendError: error];
                                       
                                   }];
        
        return nil;
        
    }];
    
    return sendRequestSignal;
}

- (RACSignal*) openRegistrationPage
{
    return [RACSignal createSignal: ^RACDisposable*(id<RACSubscriber> subscriber) {
        
        [[UIApplication sharedApplication] openURL: [LoginService getRegisterURL]];
        
        [subscriber sendCompleted];
        
        return nil;
        
    }];
}

#pragma mark - Internal -

- (void) parsingLoginResponseInfo: (NSDictionary*) info
{
    [KeyChain storeAccessToken: info[@"access_token"]];
    
    [DataManagerShared persistUserWithInfo: info];
}

@end
