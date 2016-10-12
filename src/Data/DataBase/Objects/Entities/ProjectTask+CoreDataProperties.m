//
//  ProjectTask+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 10/12/16.
//
//

#import "ProjectTask+CoreDataProperties.h"

@implementation ProjectTask (CoreDataProperties)

+ (NSFetchRequest<ProjectTask *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTask"];
}

@dynamic access;
@dynamic attachments;
@dynamic closedDate;
@dynamic descriptionValue;
@dynamic duration;
@dynamic endDate;
@dynamic extraId;
@dynamic isAllRooms;
@dynamic isExpired;
@dynamic isIncludedRestDays;
@dynamic isSelected;
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
@dynamic commentsCount;
@dynamic marker;
@dynamic ownerUser;
@dynamic project;
@dynamic responsible;
@dynamic room;
@dynamic roomLevel;
@dynamic rooms;
@dynamic stage;
@dynamic subTasks;
@dynamic taskRoleAssignments;
@dynamic workArea;

@end
