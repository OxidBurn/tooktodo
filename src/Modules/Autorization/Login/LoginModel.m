//
//  LoginModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//


#import "LoginModel.h"

// Classes
#import "LoginAPIService.h"
#import "UserAPIService.h"
#import "KeyChainManager.h"
#import "UserInfoData.h"
#import "ProjectsService.h"

// Extensions
#import "NSString+Utils.h"
#import "DataManager+UserInfo.h"
#import "DataManager+ProjectInfo.h"

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
        
        RACSignal* requestSignal = [[LoginAPIService sharedInstance] sendRequestWithCredentials: email
                                                                                   withPassword: password];
        
        
        [requestSignal subscribeNext: ^(RACTuple* x) {
            
            @strongify(self)
            
            [self saveUserToken: [x objectAtIndex: 0]];
            
            [[[UserAPIService sharedInstance] getUserInfo] subscribeNext: ^(RACTuple* response) {
                
                [KeyChain storeUserPassword: password];
                
                [self parsingLoginResponseInfo: [response objectAtIndex: 0]
                                withCompletion: ^(BOOL isSuccess) {
                    
                                    [self getUserProjects];
                                    
                                    [subscriber sendNext: [response objectAtIndex: 0]];
                                    [subscriber sendCompleted];
                                    
                }];
            }];
            
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
        
        [[UIApplication sharedApplication] openURL: [[LoginAPIService sharedInstance] getRegisterURL]];
        
        [subscriber sendCompleted];
        
        return nil;
        
    }];
}

- (void) getUserProjects
{
    [[[ProjectsService sharedInstance] getAllProjectsList] subscribeCompleted:^{
        
        [DataManagerShared markFirstProjectAsSelected];
        
    }];
}

#pragma mark - Internal -

- (void) parsingLoginResponseInfo: (NSDictionary*)           info
                   withCompletion: (void(^)(BOOL isSuccess)) completion
{
    UserInfoData* userInfo = [[UserInfoData alloc] initWithDictionary: info
                                                                error: nil];
    
    [DataManagerShared persistUserWithInfo: userInfo
                            withCompletion: ^(BOOL isSuccess) {
                                
                                completion(isSuccess);
                                
                            }];
}

- (void) saveUserToken: (NSDictionary*) response
{
    [KeyChain storeAccessToken: response[@"access_token"]];
}

@end
