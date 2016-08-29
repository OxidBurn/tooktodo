//
//  AddContactViewModel.m
//  TookTODO
//
//  Created by Lera on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddContactViewModel.h"

// Classes
#import "AddContactModel.h"
#import "Utils.h"

@interface AddContactViewModel()

@property (nonatomic, strong) AddContactModel* model;

@end

@implementation AddContactViewModel

#pragma mark - Initialization -

- (instancetype) init
{
    self = [super init];
    
    if (self)
    {
        [self initialize];
    }
    
    return self;
}

- (void) initialize
{
    self.validEmailSignal = [RACObserve(self, emailText) map: ^id(NSString* text) {
        
        return @([Utils isValidEmail: text]);
        
    }];
    
    
    
    //returns not empty name
    self.notEmptyLastnameSignal = [RACObserve(self, lastnameText) map: ^id(NSString* text) {
        
        return @([self.model isValidLastName: text]);
        
    }];
    
    
    self.notEmptyNameSignal = [RACObserve(self, nameText) map: ^id(NSString* text) {
        
        return @([self.model isValidName: text]);
        
    }];
    
    RACSignal* activeReadySignal = [RACSignal combineLatest: @[self.validEmailSignal, self.notEmptyNameSignal, self.notEmptyLastnameSignal]
                                                     reduce: ^id(NSNumber* emailValid, NSNumber* nameValid, NSNumber* lastnameValid) {
                                                         
                                                         return @([emailValid boolValue] && [nameValid boolValue] && [lastnameValid boolValue]);
                                                         
                      }];
    
    
    //Создает команду, которая активна тогда, когда activeReadySignal возвращает тру,
    self.readyCommand = [[RACCommand alloc] initWithEnabled: activeReadySignal
                                                signalBlock: ^RACSignal *(id input) {
                                                    
                                                    return  [[RACSignal empty]
                                                             delay: 2];
                                                }];
    
}

#pragma mark - Properties -

- (AddContactModel*) model
{
    if ( _model == nil )
    {
        _model = [AddContactModel new];
    }
    
    return _model;
}

#pragma mark - Public -

- (RACSignal*) getEmailWarningSignal
{
    return [RACObserve(self, emailText) map: ^NSString* (NSString* value) {
        
        return [self.model getEmailWarningText: value];
        
    }];
}

- (RACSignal*) returnInvitationInfo
{
    return  [self.model getUserInfo: self.lastnameText
                           withName: self.nameText
                          withEmail: self.emailText
                           withRole: self.roleText
                           withText: self.messageText];
}


@end
