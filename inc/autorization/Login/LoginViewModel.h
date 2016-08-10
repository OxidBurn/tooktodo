//
//  LoginViewModel.h
//  TookTODO
//
//  Created by Глеб on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"
#import <Foundation/Foundation.h>


@interface LoginViewModel : NSObject

// properties

@property (strong, nonatomic) NSString* emailValue;

@property (strong, nonatomic) NSString* passwordValue;

@property (strong, nonatomic) RACCommand* excludeLogin;

@property (strong, nonatomic) RACCommand* excludeRegistration;

@property (strong, nonatomic) RACCommand* excludeForgotPass;

// methods



@end
