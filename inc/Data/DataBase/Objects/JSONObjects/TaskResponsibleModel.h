//
//  TaskResponsibleModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TaskAssigneeModel.h"
#import "TaskProjectRoleTypeModel.h"

@interface TaskResponsibleModel : JSONModel

@property (strong, nonatomic) TaskAssigneeModel<Optional>* assignee;
@property (strong, nonatomic) NSNumber<Optional>* responsibleID;
@property (strong, nonatomic) NSNumber<Optional>* invite;
@property (strong, nonatomic) NSNumber<Optional>* isBlocked;
@property (strong, nonatomic) NSNumber<Optional>* projectPermission;
@property (strong, nonatomic) TaskProjectRoleTypeModel<Optional> * projectRoleType;

@property (strong, nonatomic) NSString<Optional>* firstName;
@property (strong, nonatomic) NSString<Optional>* lastName;
@property (strong, nonatomic) NSString<Optional>* displayName;
@property (strong, nonatomic) NSString<Optional>* avatarSrc;
@property (strong, nonatomic) NSNumber<Optional>* isActiveUser;

@end
