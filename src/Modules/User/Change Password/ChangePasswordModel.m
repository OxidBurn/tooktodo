//
//  ChangePasswordModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ChangePasswordModel.h"
#import "UserAPIService.h"

// Framewors
#import "KeyChainManager.h"


@implementation ChangePasswordModel

- (BOOL) isCorrectOldPassword: (NSString*) password
{
	return [KeyChain isCorrectEnteredPassword: password];
}

- (RACSignal*) sendUpdatingPassword: (NSString*) oldPassword
                    withNewPassword: (NSString*) pass
{
    return [[UserAPIService sharedInstance] updatePasswordFromOld: oldPassword
                                                             toNew: pass];
}

- (void) needToUpdatePassword: (NSString*) newPass
{
    [KeyChain storeUserPassword: newPass];
}

@end
