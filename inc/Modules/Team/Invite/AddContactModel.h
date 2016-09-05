//
//  AddContactModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "InviteInfo.h"

@interface AddContactModel : NSObject

- (BOOL) isValidName: (NSString*) name;

- (BOOL) isValidLastName: (NSString*) lastname;

- (NSString*) getEmailWarningText: (NSString*) email;

- (RACSignal*) sendInvite: (InviteInfo*) info;

@end
