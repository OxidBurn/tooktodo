//
//  ProjectTaskOwner+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "ProjectTaskOwner+CoreDataProperties.h"

@implementation ProjectTaskOwner (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskOwner *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskOwner"];
}

@dynamic additionalPhoneNumber;
@dynamic avatarSrc;
@dynamic displayName;
@dynamic email;
@dynamic emailConfirmed;
@dynamic firstName;
@dynamic isSubscribedOnEmailNotifications;
@dynamic isTourViewed;
@dynamic lastName;
@dynamic ownerID;
@dynamic phoneNumber;
@dynamic userName;
@dynamic role;
@dynamic task;

@end
