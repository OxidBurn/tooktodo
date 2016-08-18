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

@property (nonatomic, strong) NSString* oldPasswordString;

@property (nonatomic, strong) NSString* updatedPasswordString;

@property (nonatomic, strong) NSString* confirmPasswordString;

@property (strong, nonatomic) RACSignal* updatePasswordWarningMessage;

// methods



@end
