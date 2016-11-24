//
//  ProjectInviteInfo+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/23/16.
//
//

#import "ProjectInviteInfo+CoreDataProperties.h"

@implementation ProjectInviteInfo (CoreDataProperties)

+ (NSFetchRequest<ProjectInviteInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectInviteInfo"];
}

@dynamic email;
@dynamic firstName;
@dynamic inviteID;
@dynamic inviteStatus;
@dynamic isCanceled;
@dynamic isUsed;
@dynamic lastName;
@dynamic message;
@dynamic projectId;
@dynamic projectName;
@dynamic projectRoleAssignment;
@dynamic projectRoleType;
@dynamic projectTaskResponsible;
@dynamic projectTaskAssignment;

@end
