//
//  ChangePasswordModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ChangePasswordModel.h"

// Framewors
#import "KeyChainManager.h"


@implementation ChangePasswordModel

- (BOOL) isEquealNewPasswordWithEntered: (NSString*) enteredPass
{
    return [KeyChain isCorrectEnteredPassword: enteredPass];
}

@end
