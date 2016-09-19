//
//  ProjectRoleAssignments+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 9/19/16.
//
//

#import "ProjectRoleAssignments+CoreDataProperties.h"

@implementation ProjectRoleAssignments (CoreDataProperties)

+ (NSFetchRequest<ProjectRoleAssignments *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectRoleAssignments"];
}

@dynamic roleID;
@dynamic isBlocked;
@dynamic projectPermission;
@dynamic project;
@dynamic invite;
@dynamic assignee;
@dynamic projectRoleType;

@end
