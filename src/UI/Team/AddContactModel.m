//
//  AddContactModel.m
//  TookTODO
//
//  Created by Lera on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddContactModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@implementation AddContactModel

#pragma mark - Public methods -

- (void)  getUserLastname: (NSString*) lastname
                 withName: (NSString*) name
                withEmail: (NSString*) email
                 withRole: (NSString*) role
              withMessage: (NSString*) message
            withInfoBlock: (ReturnInfoBlock) completionBlock
{
    InviteInfo* user = [[InviteInfo alloc] init];
    
    user.lastname = lastname;
    user.name  = name;
    user.email = email;
    user.role = role;
    user.message = message;
    
    if (completionBlock) {
        completionBlock(user);
    }
    
}


- (RACSignal*) getUserInfo: (NSString*) lastname
                  withName: (NSString*) name
                 withEmail: (NSString*) email
                  withRole: (NSString*) role
                  withText: (NSString*) message
{
    @weakify(self);
    
    RACSignal* sign = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        
        @strongify(self)
        
        [self getUserLastname: lastname
                     withName: name
                    withEmail: email
                     withRole: role
                  withMessage: message
                withInfoBlock: ^(InviteInfo *userInfo) {
                    [subscriber sendNext: userInfo];
                    [subscriber sendCompleted];
                }];
        
        return nil;
    }];
    
    
    return sign;
}


- (NSString*) getEmailWarningText: (NSString*) email
{
    if (email.length == 0)
    {
        return @"Электронная почта";
    }
    else
        if ( [self isValidEmail: email] == NO )
        {
            return @"Почта указана не верно";
        }
    
    return @"Электронная почта";
}

-(BOOL) isValidEmail: (NSString*) checkString
{
    BOOL stricterFilter = NO;
    NSString *stricterFilterString = @"^[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}$";
    NSString *laxString = @"^.+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*$";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (BOOL) isValidName: (NSString*) name
{
    return name.length >= 2;
}

- (BOOL) isValidLastName: (NSString*) lastname
{
    return lastname.length >= 2;
}

@end
