//
//  ProjectTaskAssignee+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 9/19/16.
//
//

#import "ProjectTaskAssignee+CoreDataProperties.h"

@implementation ProjectTaskAssignee (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskAssignee *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskAssignee"];
}

@dynamic additionalPhoneNumber;
@dynamic assigneeID;
@dynamic avatarSrc;
@dynamic displayName;
@dynamic email;
@dynamic emailConfirmed;
@dynamic firstName;
@dynamic isSubscribedOnEmailNotifications;
@dynamic isTourViewed;
@dynamic lastName;
@dynamic phoneNumber;
@dynamic userName;
@dynamic responsible;
@dynamic role;
@dynamic roleAssignment;
@dynamic projectRoleAssignment;

@end
