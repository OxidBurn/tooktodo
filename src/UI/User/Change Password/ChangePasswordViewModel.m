//
//  ChangePasswordViewModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ChangePasswordViewModel.h"
#import "ChangePasswordModel.h"

@interface ChangePasswordViewModel()

// properties

@property (strong, nonatomic) ChangePasswordModel* model;

@property (assign, nonatomic) BOOL isNeedToSubscriptionToWarning;

@property (assign, nonatomic) BOOL isCorrectEnteredInfo;

@property (strong, nonatomic) NSString* oldPasswordString;

@property (strong, nonatomic) NSString* updatedPasswordString;

// methods


@end

@implementation ChangePasswordViewModel

#pragma mark - Properties -

- (ChangePasswordModel*) model
{
    if ( _model == nil )
    {
        _model = [ChangePasswordModel new];
    }
    
    return _model;
}


#pragma mark - Public methods -

- (RACSignal*) updatePasswordWarningMessage
{
    if ( _updatePasswordWarningMessage == nil )
    {
        @weakify(self)
        
        _updatePasswordWarningMessage = [RACSignal combineLatest: @[self.oldPasswordSignal, self.updatedPasswordSignal, self.confirmPasswordSignal]
                                                          reduce: ^id(NSString* oldPass, NSString* newPass, NSString* confirmPass){
                                                        
                                                              @strongify(self)
                                                              
                                                         if ( [self.model isCorrectOldPassword: oldPass] == NO )
                                                         {
                                                             self.isCorrectEnteredInfo = NO;
                                                             
                                                             return @"Старый пароль не совпадает с текущим";
                                                         }
                                                         else
                                                             if ( [newPass isEqualToString: confirmPass] == NO )
                                                             {
                                                                 self.isCorrectEnteredInfo = NO;
                                                                 
                                                                 return @"Новый данные не совпадают.";
                                                             }
                                                         else
                                                             if ( newPass.length < 6 || oldPass.length < 6 )
                                                             {
                                                                 self.isCorrectEnteredInfo = NO;
                                                                 
                                                                 return @"Новый пароль должен содержать более 5и символов";
                                                             }
                                                         
                                                              self.isCorrectEnteredInfo  = YES;
                                                              self.oldPasswordString     = oldPass;
                                                              self.updatedPasswordString = newPass;
                                                              
                                                         return @"";
                                                     }];
    }
    
    return _updatePasswordWarningMessage;
}

- (RACCommand*) changePassCommand
{
    if ( _changePassCommand == nil )
    {
        @weakify(self)
        
        _changePassCommand = [[RACCommand alloc] initWithSignalBlock: ^RACSignal *(id input) {
           
            @strongify(self)
            
            return [self updatingPasswordSignal];
        }];
    }
    
    return _changePassCommand;
}


#pragma mark - Internal methods -

- (RACSignal*) updatingPasswordSignal
{
    @weakify(self)
    
    RACSignal* newSignal = [RACSignal createSignal: ^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self)
        
        if ( self.isCorrectEnteredInfo )
        {
            [[self.model sendUpdatingPassword: self.oldPasswordString
                              withNewPassword: self.updatedPasswordString] subscribeNext: ^(id x) {
                
                [subscriber sendNext: x];
                
            }
             error: ^(NSError *error) {
                 
                 [subscriber sendError: error];
             }
             completed: ^{
                 
                 [self.model needToUpdatePassword: self.updatedPasswordString];
                 
                 [subscriber sendNext: nil];
                 [subscriber sendCompleted];
                 
             }];
        }
        else
            if ( self.isNeedToSubscriptionToWarning == NO )
        {
            NSError* enteredInfoError = [NSError errorWithDomain: @"UpdatePasswordErrorDomain"
                                                            code: 101
                                                        userInfo: nil];
            
            [subscriber sendError: enteredInfoError];
            
            self.isNeedToSubscriptionToWarning = YES;
        }
        else
        {
            [subscriber sendNext: nil];
        }
        
        return nil;
    }];
    
    return newSignal;
}

@end
