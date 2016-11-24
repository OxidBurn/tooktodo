//
//  ProjectTaskRoleAssignments+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/23/16.
//
//

#import "ProjectTaskRoleAssignments+CoreDataProperties.h"

@implementation ProjectTaskRoleAssignments (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoleAssignments *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskRoleAssignments"];
}

@dynamic roleAssignmentsID;
@dynamic taskRoleType;
@dynamic taskRoleTypeDescription;
@dynamic task;
@dynamic projectRoleAssignment;

@end
