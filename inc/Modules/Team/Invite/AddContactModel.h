//
//  AddContactModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InviteInfo.h"

@interface AddContactModel : NSObject

- (BOOL) isValidName: (NSString*) name;

- (BOOL) isValidLastName: (NSString*) lastname;

- (NSString*) getEmailWarningText: (NSString*) email;

- (RACSignal*) getUserInfo: (NSString*) lastname
                  withName: (NSString*) name
                 withEmail: (NSString*) email
                  withRole: (NSString*) role
                  withText: (NSString*) message;
@end
