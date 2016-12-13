//
//  TeamMember+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "TeamMember+CoreDataProperties.h"

@implementation TeamMember (CoreDataProperties)

+ (NSFetchRequest<TeamMember *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TeamMember"];
}

@dynamic additionalPhoneNumber;
@dynamic avatarSrc;
@dynamic comment;
@dynamic company;
@dynamic createrUserId;
@dynamic email;
@dynamic firstName;
@dynamic isSelected;
@dynamic lastName;
@dynamic patronymicName;
@dynamic phoneNumber;
@dynamic userID;
@dynamic project;

@end
