//
//  ProjectTask+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 9/18/16.
//
//

#import "ProjectTask+CoreDataProperties.h"

@implementation ProjectTask (CoreDataProperties)

+ (NSFetchRequest<ProjectTask *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTask"];
}

@dynamic access;
@dynamic closedDate;
@dynamic descriptionValue;
@dynamic duration;
@dynamic endDate;
@dynamic extraId;
@dynamic isAllRooms;
@dynamic isExpired;
@dynamic isIncludedRestDays;
@dynamic isTaskStatusChanged;
@dynamic isUrgent;
@dynamic mapPreviewImage;
@dynamic ownerUserId;
@dynamic parentTaskId;
@dynamic projectId;
@dynamic projectRelatedId;
@dynamic startDay;
@dynamic status;
@dynamic statusDescription;
@dynamic storageDirectoryId;
@dynamic storageFilesCount;
@dynamic taskAccess;
@dynamic taskDescription;
@dynamic taskID;
@dynamic taskType;
@dynamic taskTypeDescription;
@dynamic title;
@dynamic attachments;
@dynamic marker;
@dynamic ownerUser;
@dynamic project;
@dynamic responsible;
@dynamic roomLevel;
@dynamic rooms;
@dynamic stage;
@dynamic subTasks;
@dynamic taskRoleAssignments;
@dynamic workArea;
@dynamic room;

@end
