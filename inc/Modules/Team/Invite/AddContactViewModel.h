//
//  AddContactViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface AddContactViewModel : NSObject

// Properties
@property (strong, nonatomic)  NSString* lastnameText;
@property (strong, nonatomic)  NSString* nameText;
@property (strong, nonatomic)  NSString* emailText;
@property (strong, nonatomic)  NSNumber* roleID;
@property (strong, nonatomic)  NSString* messageText;

@property (nonatomic, strong) RACSignal  * validEmailSignal;
@property (nonatomic, strong) RACCommand * readyCommand;
@property (nonatomic, strong) RACSignal  * notEmptyLastnameSignal;
@property (nonatomic, strong) RACSignal  * notEmptyNameSignal;

//Methods
- (RACSignal*) getEmailWarningSignal;

@end
