//
//  AddContactViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddContactViewModel.h"

// Classes
#import "AddContactModel.h"
#import "Utils.h"
#import "InviteInfo.h"
#import "ProjectInviteInfo+CoreDataClass.h"

typedef NS_ENUM(NSUInteger, InviteTextFieldType)
{
    NameTextFieldType  = 0,
    EmailTextFieldType = 1,
};

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

    //Создает команду, которая активна тогда, когда activeReadySignal возвращает тру,
    @weakify(self)
    
    self.readyCommand = [[RACCommand alloc] initWithEnabled: self.validEmailSignal
                                                signalBlock: ^RACSignal *(id input) {
                                                    
                                                    @strongify(self)
                                                    
                                                    return  [self sendInvite];
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

- (RACSignal*) sendInvite
{
    InviteInfo* info = [InviteInfo new];
    
    info.firstName         = self.nameText;
    info.lastName          = self.lastnameText;
    info.email             = self.emailText;
    info.message           = self.messageText;
    info.userId            = @0;
    info.contactId         = @0;
    
    if ( self.roleID )
        info.projectRoleTypeId = self.roleID;
    
    return [self.model sendInvite: info];
}


#pragma mark - Text field delegate methods -

- (BOOL)             textField: (UITextField*) textField
 shouldChangeCharactersInRange: (NSRange)      range
             replacementString: (NSString*)    string
{
    if ( textField.tag == NameTextFieldType )
    {
        BOOL isShould = NO;
        
        if ( textField.text.length < 64 )
            isShould = YES;
        
        return isShould;
    }
    
    return YES;
}

- (void) textFieldDidEndEditing: (UITextField*) textField
{
    if ( textField.tag == EmailTextFieldType )
    {
        NSString* emailWarningText = [self.model getEmailWarningText: textField.text];
        
        if ( self.showValidEmailWarning )
            self.showValidEmailWarning(emailWarningText);
    }
}

- (void) textFieldDidBeginEditing: (UITextField*) textField
{
    if ( textField.tag == EmailTextFieldType )
    {
        if ( self.showValidEmailWarning )
            self.showValidEmailWarning(@"Электронная почта");
    }
}

@end
