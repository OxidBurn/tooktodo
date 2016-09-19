//
//  ProjectInfo+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 9/19/16.
//
//

#import "ProjectInfo+CoreDataProperties.h"

@implementation ProjectInfo (CoreDataProperties)

+ (NSFetchRequest<ProjectInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectInfo"];
}

@dynamic address;
@dynamic apartment;
@dynamic building;
@dynamic city;
@dynamic commercialObjectType;
@dynamic commercialObjectTypeDescription;
@dynamic createdDate;
@dynamic endDate;
@dynamic floor;
@dynamic isExpanded;
@dynamic isRolesInvitationAppealClosed;
@dynamic isSelected;
@dynamic isTaskAddAppealClosed;
@dynamic lastVisit;
@dynamic ownerUserId;
@dynamic phoneNumber;
@dynamic projectID;
@dynamic realtyClass;
@dynamic realtyClassDescription;
@dynamic regionName;
@dynamic residentialObjectType;
@dynamic residentialObjectTypeDescription;
@dynamic street;
@dynamic title;
@dynamic country;
@dynamic offlineSettings;
@dynamic region;
@dynamic roles;
@dynamic stage;
@dynamic systems;
@dynamic tasks;
@dynamic team;
@dynamic projectRoleAssignments;

@end
