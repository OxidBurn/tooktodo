//
//  ProjectTaskRoleAssignment+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 24.11.16.
//
//

#import "ProjectTaskRoleAssignment+CoreDataProperties.h"

@implementation ProjectTaskRoleAssignment (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoleAssignment *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskRoleAssignment"];
}

@dynamic isBlocked;
@dynamic projectPermission;
@dynamic taskRoleAssignmnetID;
@dynamic assignee;
@dynamic invite;
@dynamic projectRoleAssignments;
@dynamic projectRoleType;

@end
