//
//  TaskProjectRoleAssignmentModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TaskAssigneeModel.h"
#import "ProjectInviteInfoModel.h"
#import "TaskProjectRoleTypeModel.h"

@interface TaskProjectRoleAssignmentModel : JSONModel

@property (strong, nonatomic) NSNumber* taskRoleAssignmnetID;
@property (strong, nonatomic) NSNumber* projectPermission;
@property (strong, nonatomic) NSNumber* isBlocked;

@property (strong, nonatomic) TaskAssigneeModel<Optional>        * assignee;
@property (strong, nonatomic) ProjectInviteInfoModel<Optional>   * invite;
@property (strong, nonatomic) TaskProjectRoleTypeModel<Optional> * projectRoleType;


@end
