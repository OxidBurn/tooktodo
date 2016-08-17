//
//  LoginViewModel.m
//  TookTODO
//
//  Created by Глеб on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "LoginViewModel.h"
#import "LoginModel.h"
#import "RecoveryViewModel.h"
#import "KeyChainManager.h"

@interface LoginViewModel()

// properties

@property (strong, nonatomic) LoginModel* model;

@property (assign, nonatomic) BOOL isEnableHandlingWarnings;

// methods


@end

@implementation LoginViewModel

#pragma mark - Properties -

- (LoginModel *)model
{
    if ( _model == nil )
    {
        _model = [LoginModel new];
    }
    
    return _model;
}

#pragma mark - Warnings messages -

- (RACSignal*) emailWarningMessage
{
    @weakify(self)
    
    return [RACObserve(self, emailValue) map: ^NSString*(NSString* value) {
        
        @strongify(self)
        
        return [self.model getWarningMessageForEmail: value];
        
    }];;
}

- (RACSignal*) passwordWarningMessage
{
    @weakify(self)
    
    return [RACObserve(self, passwordValue) map: ^NSString*(NSString* value) {
        
        @strongify(self)
        
        return [self.model getWarningMessageForPassowrd: value];
    }];;
}

#pragma mark - Commands -

- (RACCommand*) loginCommand
{
    @weakify(self)
    
    return [[RACCommand alloc] initWithSignalBlock: ^RACSignal *(id input) {
        
        @strongify(self)
        
        return [self sendingLogingRequest];
        
    }];
}

- (RACCommand*) restorePassCommand
{
    @weakify(self)
    
    return [[RACCommand alloc] initWithSignalBlock: ^RACSignal *(id input) {
        
        @strongify(self)
        
        return [self restoreEmailSignal];
        
    }];
}

- (RACCommand*) registerCommand
{
    @weakify(self)
    return [[RACCommand alloc] initWithSignalBlock: ^RACSignal *(id input) {
       
        @strongify(self)
        return [self.model openRegistrationPage];
        
    }];
}

#pragma mark - Internal method -

- (RACSignal*) sendingLogingRequest
{
    @weakify(self)
    
    RACSignal* sendRequestSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self)
        
        if ( [self.model isValidEnteredCreadentials: self.emailValue
                                        andPassword: self.passwordValue] )
        {
            [[self.model sendRequestWithCredentials: self.emailValue
                                       withPassword: self.passwordValue] subscribeNext: ^(NSDictionary* x) {
                
                [subscriber sendNext: x];
                [subscriber sendCompleted];
                
            }
             error: ^(NSError* error) {
                 
                 [subscriber sendError: error];
                 
             }
             completed: ^{
                 
                 [subscriber sendCompleted];
                 
             }];
        }
        else
            if ( self.isEnableHandlingWarnings == NO )
            {
                [subscriber sendError: [NSError errorWithDomain: @"SubscribeToHandleErrors"
                                                           code: 101
                                                       userInfo: nil]];
                
                self.isEnableHandlingWarnings = YES;
            }
            else
            {
                [subscriber sendNext: nil];
            }
        
        return nil;
    }];
    
    return sendRequestSignal;
}

- (RACSignal*) restoreEmailSignal
{
    @weakify(self)
    
    return [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self)
        
        RecoveryViewModel* recoveryModel = [[RecoveryViewModel alloc] initWithEmail: self.emailValue];
        
        [subscriber sendNext: recoveryModel];
        [subscriber sendCompleted];
        
        return nil;
    }];
}

@end
