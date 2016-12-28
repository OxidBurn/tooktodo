//
//  UpdateUserInfoModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 8/18/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKNumericFormatter.h"
#import "UpdatedUserInfo.h"

@interface UpdateUserInfoModel : NSObject

- (NSString*) getUserName;

- (NSString*) getSurName;

- (NSString*) getUserPhoneNumber;

- (NSString*) getUserAdditionalPhoneNumber;

- (void) updateUserValues: (UpdatedUserInfo*)        newInfo
           withCompletion: (void(^)(BOOL isSuccess)) completion;

- (NSString*) getPhoneNumberFormatString;

- (AKNumericFormatter*) getPhoneNumberFormat;

@end
