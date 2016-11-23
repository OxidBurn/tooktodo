//
//  ProjectTaskResponsible+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/22/16.
//
//

#import "ProjectTaskResponsible+CoreDataProperties.h"

@implementation ProjectTaskResponsible (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskResponsible *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskResponsible"];
}

@dynamic avatarSrc;
@dynamic displayName;
@dynamic firstName;
@dynamic isActiveUser;
@dynamic isBlocked;
@dynamic lastName;
@dynamic projectPermission;
@dynamic responsibleID;
@dynamic usedForFilters;
@dynamic assignee;
@dynamic invite;
@dynamic projectRoleType;
@dynamic task;

@end
