//
//  ChangePasswordViewModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 8/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface ChangePasswordViewModel : NSObject

// properties

@property (nonatomic, strong) RACSignal* oldPasswordSignal;

@property (nonatomic, strong) RACSignal* updatedPasswordSignal;

@property (nonatomic, strong) RACSignal* confirmPasswordSignal;

@property (strong, nonatomic) RACSignal* updatePasswordWarningMessage;

@property (strong, nonatomic) RACCommand* changePassCommand;

// methods



@end
