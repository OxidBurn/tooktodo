//
//  ProjectRoleAssignments+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 19.09.16.
//
//

#import "ProjectRoleAssignments+CoreDataProperties.h"

@implementation ProjectRoleAssignments (CoreDataProperties)

+ (NSFetchRequest<ProjectRoleAssignments *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectRoleAssignments"];
}

@dynamic isBlocked;
@dynamic projectPermission;
@dynamic roleID;
@dynamic isSelected;
@dynamic assignee;
@dynamic invite;
@dynamic project;
@dynamic projectRoleType;

@end
