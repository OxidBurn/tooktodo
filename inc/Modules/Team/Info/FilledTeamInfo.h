//
//  FilledTeamInfo.h
//  TookTODO
//
// Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

//Categories
#import "ProjectTaskAssignee+CoreDataClass.h"
#import "ProjectInviteInfo+CoreDataClass.h"
#import "ProjectRoleAssignments+CoreDataProperties.h"
#import "ProjectRoleAssignments+CoreDataClass.h"
#import "ProjectRoles+CoreDataProperties.h"
#import "ProjectRoleType+CoreDataProperties.h"
#import "ProjectTaskOwner+CoreDataProperties.h"
#import "UserInfo.h"

@interface FilledTeamInfo : NSObject

@property (nonatomic, strong) NSNumber* userId;
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* phoneNumber;
@property (nonatomic, strong) NSString* additionalPhoneNumber;
@property (nonatomic, strong) NSString* role;
@property (nonatomic, strong) NSString* avatarSrc;
@property (nonatomic, strong) NSString* fullname;
@property (nonatomic, assign) NSNumber* projectPermission;
@property (strong, nonatomic) NSNumber* roleID;
@property (strong, nonatomic) NSNumber* memberID;
@property (strong, nonatomic) NSNumber* projectID;
@property (strong, nonatomic) NSNumber* taskRoleAssinment;
@property (nonatomic, assign) BOOL hasApprovedTask;
@property (nonatomic, assign) BOOL isBlocked;
@property (nonatomic, strong) ProjectRoleAssignments* assignments;

- (void) fillTeamInfo: (ProjectRoleAssignments*) assignment;

- (void) convertUserToTeamInfo: (UserInfo*) user;

- (void) convertTaskOwnerToTeamInfo: (ProjectTaskOwner*) projectOwner;

- (void) convertTaskResponsibleToTeamInfo: (ProjectTaskResponsible*) taskResponsible;

@end
