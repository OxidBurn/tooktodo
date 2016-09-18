//
//  TaskProjectRoleAssignmentModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TaskAssigneeModel.h"
#import "TaskProjectRoleTypeModel.h"

@interface TaskProjectRoleAssignmentModel : JSONModel

@property (strong, nonatomic) TaskAssigneeModel<Optional>        * assignee;
@property (strong, nonatomic) TaskProjectRoleTypeModel<Optional> * projectRoleType;

@end
