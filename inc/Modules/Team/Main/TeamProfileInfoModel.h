//
//  TeamProfileInfoModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 06.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
#import "ReactiveCocoa.h"

//Classes
#import "ProjectRoles.h"
#import "FilledTeamInfo.h"

@protocol TeamProfileInfoModelDelegate;

@interface TeamProfileInfoModel : NSObject

// properties

@property (weak, nonatomic) id <TeamProfileInfoModelDelegate> delegate;

// methods

- (RACSignal*) updateUserInfo;

- (NSString*) getEmail;

- (NSString*) getPhone;

- (NSString*) getAdditionalPhone;

- (NSString*) getMemberName;

- (NSInteger) countOfContactsContent;

- (NSInteger) secondSectionRowCount;

- (NSString*) getAvatar;

- (NSString*) getRole;

- (NSNumber*) getPermissions;

- (NSInteger) getCurrentUserPermission;

- (NSString*) getContactValueForIndexPath: (NSIndexPath*) indexPath;

- (UIImage*) getBtnImageForIndexPath: (NSIndexPath*) indexPath;

- (void) performActionForIndex: (NSUInteger) index;

- (NSString*) getRoleInfoCellLabelTextForIndexPath: (NSIndexPath*) indexPath;

- (NSString*) getDetailRoleCellLabelTextForIndexPath: (NSIndexPath*) indexPath;

- (void) updateMemberPermission: (NSInteger) permission;

- (void) reloadContent;

- (void) updateMemberRole: (ProjectRoles*) role;

- (void) fillSelectedTeamMember: (FilledTeamInfo*) teamMember;

- (BOOL) checkIfTeamMemberBlockedOrInvited;

@end

@protocol TeamProfileInfoModelDelegate <NSObject>

// methods

- (void) sendEmailToAdress: (NSString*) email;


@end
