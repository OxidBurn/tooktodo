//
//  LoginViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"
#import <Foundation/Foundation.h>


@interface LoginViewModel : NSObject

// properties

// Reactive operations
@property (strong, nonatomic) RACCommand* loginCommand;

@property (strong, nonatomic) RACCommand* registerCommand;

@property (strong, nonatomic) RACCommand* restorePassCommand;

// Creadentials values
@property (strong, nonatomic) NSString* emailValue;

@property (strong, nonatomic) NSString* passwordValue;

// methods

- (NSString*) getStoredEmailValue;

- (RACSignal*) emailWarningMessage;

- (RACSignal*) passwordWarningMessage;

@end
