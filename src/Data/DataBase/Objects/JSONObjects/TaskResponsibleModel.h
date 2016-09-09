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

@property (strong, nonatomic) TaskAssigneeModel        * assignee;
@property (assign, nonatomic) BOOL                     id;
@property (assign, nonatomic) BOOL                     * invite;
@property (assign, nonatomic) BOOL                     isBlocked;
@property (assign, nonatomic) NSUInteger               projectPermission;
@property (strong, nonatomic) TaskProjectRoleTypeModel * projectRoleType;

@end
