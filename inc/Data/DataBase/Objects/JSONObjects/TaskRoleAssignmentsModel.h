//
//  TaskRoleAssignmentsModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TaskProjectRoleAssignmentModel.h"

@interface TaskRoleAssignmentsModel : JSONModel

@property (assign, nonatomic) NSUInteger                     roleAssignmentsID;
@property (strong, nonatomic) TaskProjectRoleAssignmentModel * projectRoleAssignment;
@property (assign, nonatomic) NSUInteger                     taskRoleType;
@property (strong, nonatomic) NSString                       * taskRoleTypeDescription;

@end
