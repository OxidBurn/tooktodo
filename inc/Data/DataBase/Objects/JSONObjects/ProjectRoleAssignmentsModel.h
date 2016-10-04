//
//  ProjectRoleAssignments.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/19/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <JSONModel/JSONModel.h>

// Classes
#import "TaskAssigneeModel.h"
#import "ProjectRoleTypeModel.h"
#import "ProjectInviteInfoModel.h"

@protocol ProjectRoleAssignmentsModel;

@interface ProjectRoleAssignmentsModel : JSONModel

@property (strong, nonatomic) NSNumber* roleID;
@property (strong, nonatomic) TaskAssigneeModel<Optional>* assignee;
@property (strong, nonatomic) ProjectInviteInfoModel<Optional>* invite;
@property (assign, nonatomic) BOOL isBlocked;
@property (assign, nonatomic) NSUInteger projectPermission;
@property (strong, nonatomic) ProjectRoleTypeModel<Optional>* projectRoleType;

@end
