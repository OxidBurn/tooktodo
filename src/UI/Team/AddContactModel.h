//
//  AddContactModel.h
//  TookTODO
//
//  Created by Lera on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InviteInfo.h"

@interface AddContactModel : NSObject

typedef void(^UserInfoBlock)(NSString* lastname, NSString* name, NSString* email, NSString* role, NSString* message);

typedef void(^ReturnInfoBlock)(InviteInfo* userInfo);

- (BOOL) isValidEmail: (NSString*) checkString;

- (BOOL) isValidName: (NSString*) name;

- (BOOL) isValidLastName: (NSString*) lastname;

- (NSString*) getEmailWarningText: (NSString*) email;


- (RACSignal*) getUserInfo: (NSString*) lastname
                  withName: (NSString*) name
                 withEmail: (NSString*) email
                  withRole: (NSString*) role
                  withText: (NSString*) message;




@end
