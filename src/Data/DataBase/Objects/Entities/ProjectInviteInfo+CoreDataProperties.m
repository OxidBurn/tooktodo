//
//  ProjectInviteInfo+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 9/19/16.
//
//

#import "ProjectInviteInfo+CoreDataProperties.h"

@implementation ProjectInviteInfo (CoreDataProperties)

+ (NSFetchRequest<ProjectInviteInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectInviteInfo"];
}

@dynamic email;
@dynamic firstName;
@dynamic lastName;
@dynamic inviteID;
@dynamic inviteStatus;
@dynamic isCanceled;
@dynamic isUsed;
@dynamic message;
@dynamic projectId;
@dynamic projectName;
@dynamic projectRoleAssignment;
@dynamic projectRoleType;

@end
