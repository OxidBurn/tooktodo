//
//  ChangePasswordModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 8/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface ChangePasswordModel : NSObject

// properties


// methods

- (BOOL) isCorrectOldPassword: (NSString*) password;

- (RACSignal*) sendUpdatingPassword: (NSString*) oldPassword
                    withNewPassword: (NSString*) pass;

- (void) needToUpdatePassword: (NSString*) newPass;


@end
