//
//  ProjectTaskResponsible+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 9/18/16.
//
//

#import "ProjectTaskResponsible+CoreDataProperties.h"

@implementation ProjectTaskResponsible (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskResponsible *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskResponsible"];
}

@dynamic invite;
@dynamic isBlocked;
@dynamic projectPermission;
@dynamic responsibleID;
@dynamic firstName;
@dynamic lastName;
@dynamic displayName;
@dynamic avatarSrc;
@dynamic isActiveUser;
@dynamic assignee;
@dynamic projectRoleType;
@dynamic task;

@end
