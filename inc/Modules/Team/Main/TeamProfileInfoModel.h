//
//  TeamProfileInfoModel.h
//  TookTODO
//
//  Created by Глеб on 06.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
#import "ReactiveCocoa.h"

@protocol TeamProfileInfoModelDelegate;

@interface TeamProfileInfoModel : NSObject

// properties

@property (weak, nonatomic) id<TeamProfileInfoModelDelegate> delegate;

// methods

- (RACSignal*) updateUserInfo;

- (NSString*) getEmail;

- (NSString*) getPhone;

- (NSString*) getAdditionalPhone;

- (NSString*) getMemberName;

- (NSInteger) countOfContactsContent;

- (UIImage*) getAvatar;

- (NSNumber*) getPermissions;



- (NSString*) getContactValueForIndexPath: (NSIndexPath*) indexPath;

- (UIImage*) getBtnImageForIndexPath: (NSIndexPath*) indexPath;

- (void) performActionForIndex: (NSUInteger) index;

- (NSString*) getRoleInfoCellLabelTextForIndexPath: (NSIndexPath*) indexPath;

- (NSString*) getDetailRoleCellLabelTextForIndexPath: (NSIndexPath*) indexPath;
@end

@protocol TeamProfileInfoModelDelegate <NSObject>

// methods

- (void) sendEmailToAdress: (NSString*) email;

@end
