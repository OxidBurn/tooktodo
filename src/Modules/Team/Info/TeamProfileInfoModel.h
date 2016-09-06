//
//  TeamProfileInfoModel.h
//  TookTODO
//
//  Created by Lera on 05.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

@interface TeamProfileInfoModel : NSObject

// properties


// methods

- (RACSignal*) updateUserInfo;

- (NSString*) getEmail;

- (NSString*) getPhone;

- (NSString*) getAdditionalPhone;

- (NSString*) getMemberName;

- (NSInteger) countOfContactsContent;

- (NSString*) getContactValueForIndexPath: (NSIndexPath*) indexPath;

- (UIImage*) getBtnImageForIndexPath: (NSIndexPath*) indexPath;

- (void) performActionForIndex: (NSUInteger) index;

@end
