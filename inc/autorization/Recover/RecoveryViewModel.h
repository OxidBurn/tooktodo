//
//  RecoveryViewModel.h
//  TookTODO
//
//  Created by Глеб on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface RecoveryViewModel : NSObject

// properties

// FPR
@property (strong, nonatomic) RACCommand* resetPassCommand;
@property (strong, nonatomic) RACCommand* registerCommand;

@property (strong, nonatomic) NSString* emailValue;

// methods

- (instancetype) initWithEmail: (NSString*) email;

- (RACSignal*) emailWarningMessage;

- (NSString*) getSuccessRestorePassLabel;

@end
