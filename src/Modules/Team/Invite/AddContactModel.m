//
//  AddContactModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddContactModel.h"

// Frameworks
#import <ReactiveCocoa/ReactiveCocoa.h>

// Classes
#import "Utils.h"
#import "TeamService.h"

typedef void(^ReturnInfoBlock)(InviteInfo* userInfo);

@implementation AddContactModel

#pragma mark - Public methods -

- (NSString*) getEmailWarningText: (NSString*) email
{
    if (email.length == 0)
    {
        return @"Электронная почта";
    }
    else
        if ( [Utils isValidEmail: email] == NO )
        {
            return @"Почта указана не верно";
        }
    
    return @"Электронная почта";
}

- (BOOL) isValidName: (NSString*) name
{
    return name.length >= 2;
}

- (BOOL) isValidLastName: (NSString*) lastname
{
    return lastname.length >= 2;
}

- (RACSignal*) sendInvite: (InviteInfo*) info
{
    return [[TeamService sharedInstance] inviteUserWithInfo: info];
}

@end
