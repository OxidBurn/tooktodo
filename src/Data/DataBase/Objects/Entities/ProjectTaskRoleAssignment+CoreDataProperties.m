//
//  ProjectTaskRoleAssignment+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/23/16.
//
//

#import "ProjectTaskRoleAssignment+CoreDataProperties.h"

@implementation ProjectTaskRoleAssignment (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoleAssignment *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskRoleAssignment"];
}

@dynamic taskRoleAssignmnetID;
@dynamic projectPermission;
@dynamic isBlocked;
@dynamic assignee;
@dynamic projectRoleType;
@dynamic projectRoleAssignments;
@dynamic invite;

@end
