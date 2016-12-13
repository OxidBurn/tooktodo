//
//  UpdateInfoViewModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 8/18/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKNumericFormatter.h"
#import "ReactiveCocoa.h"

@interface UpdateInfoViewModel : NSObject <UITextFieldDelegate>

// properties

@property (strong, nonatomic) NSString* userName;

@property (nonatomic, strong) NSString* userSurname;

@property (nonatomic, strong) NSString* userPhoneNumber;

@property (nonatomic, strong) NSString* userAdditionalPhoneNumber;

@property (nonatomic, strong) RACCommand* saveDataCommand;

// methods

- (AKNumericFormatter*) getPhoneNumberFormat;

@end
