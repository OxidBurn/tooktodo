//
//  RecoveryModel.h
//  TookTODO
//
//  Created by Глеб on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa.h>

@interface RecoveryModel : NSObject

- (BOOL) isValidEmail: (NSString*) email;

- (NSString*) getWarningMessageForEmail: (NSString*) email;

- (NSString*) getDefaultSuccessRecoveryMessage;

- (RACSignal*) sendRequestForResetingPassword: (NSString*) email;

- (RACSignal*) openRegistrationPage;

@end
