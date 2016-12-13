//
//  TaskRoleAssignmentsModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "TaskProjectRoleAssignmentModel.h"

@protocol TaskRoleAssignmentsModel;

@interface TaskRoleAssignmentsModel : JSONModel

@property (assign, nonatomic) NSUInteger roleAssignmentsID;
@property (assign, nonatomic) NSUInteger taskRoleType;
@property (strong, nonatomic) NSString* taskRoleTypeDescription;
@property (strong, nonatomic) TaskProjectRoleAssignmentModel<Optional> * projectRoleAssignment;

@end
