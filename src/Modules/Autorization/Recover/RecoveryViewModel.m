//
//  RecoveryViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RecoveryViewModel.h"
#import "RecoveryModel.h"

@interface RecoveryViewModel()

// properties

@property (strong, nonatomic) RecoveryModel* model;

@property (assign, nonatomic) BOOL isEnableHandlingWarnings;

// methods



@end

@implementation RecoveryViewModel

#pragma mark - Initialization -

- (instancetype) initWithEmail: (NSString*) email
{
    if ( self = [super init] )
    {
        self.emailValue = email;
    }
    
    return self;
}


#pragma mark - Properties -

- (RecoveryModel*) model
{
    if ( _model == nil )
    {
        _model = [RecoveryModel new];
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
        
    }];
}


#pragma mark - Command -

- (RACCommand*) resetPassCommand
{
    return [[RACCommand alloc] initWithSignalBlock: ^RACSignal *(id input) {
        
        return [self sendingResetRequest];
        
    }];
}

- (RACCommand*) registerCommand
{
    return [[RACCommand alloc] initWithSignalBlock: ^RACSignal *(id input) {
        
        return [self.model openRegistrationPage];
        
    }];
}

#pragma mark - Public methods -

- (NSString*) getSuccessRestorePassLabel
{
    return [[self.model getDefaultSuccessRecoveryMessage] stringByAppendingString: self.emailValue];
}


#pragma mark - Internal methods -

- (RACSignal*) sendingResetRequest
{
    @weakify(self)
    
    RACSignal* sendRequestSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self)
        
        if ( [self.model isValidEmail: self.emailValue] )
        {
            RACSignal* recoverSignal = [self.model sendRequestForResetingPassword: self.emailValue];
            
            [recoverSignal subscribeNext: ^(id x) {
                
                [subscriber sendNext: @"Available to send login request"];
                
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

@end
