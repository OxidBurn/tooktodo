//
//  ProjectRoleType+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 9/19/16.
//
//

#import "ProjectRoleType+CoreDataProperties.h"

@implementation ProjectRoleType (CoreDataProperties)

+ (NSFetchRequest<ProjectRoleType *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectRoleType"];
}

@dynamic roleTypeID;
@dynamic title;
@dynamic roleAssignment;
@dynamic projectInvite;

@end
