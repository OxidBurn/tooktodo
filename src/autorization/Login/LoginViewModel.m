//
//  LoginViewModel.m
//  TookTODO
//
//  Created by Глеб on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "LoginViewModel.h"

// Extensions
#import "NSString+Utils.h"

@interface LoginViewModel()

// properties

@property (strong, nonatomic) RACSignal* validEmailSignal;

@property (strong, nonatomic) RACSignal* validPassSignal;

// methods


@end

@implementation LoginViewModel

#pragma mark - Initialization -

- (instancetype) init
{
    if ( self = [super init] )
    {
        [self initialize];
    }
    
    return self;
}

#pragma mark - Internal methods -

- (void) initialize
{
    // Handle validation of the email string
    self.validEmailSignal = [[RACObserve(self, emailValue) map: ^id(NSString* text) {
        
        return @([text isEmailString]);
        
    }] distinctUntilChanged];
    
    // Handle validation of the password string
    self.validPassSignal = [[RACObserve(self, passwordValue) map: ^id(NSString* value) {
        
        return @(value.length > 6);
        
    }] distinctUntilChanged];
}

@end
