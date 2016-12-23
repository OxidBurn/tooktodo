//
//  TaskLogDataContent+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 12/23/16.
//
//

#import "TaskLogDataContent+CoreDataProperties.h"

@implementation TaskLogDataContent (CoreDataProperties)

+ (NSFetchRequest<TaskLogDataContent *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskLogDataContent"];
}

@dynamic commentId;
@dynamic fileTitles;
@dynamic fileTitlesWithExtensions;
@dynamic newDescription;
@dynamic newEndDate;
@dynamic newStartDate;
@dynamic newStatus;
@dynamic newValue;
@dynamic newWorkArea;
@dynamic oldDescription;
@dynamic oldEndDate;
@dynamic oldStartDate;
@dynamic oldStatus;
@dynamic oldValue;
@dynamic oldWorkArea;
@dynamic projectRoleAssignmentId;
@dynamic storageFiles;
@dynamic taskRoleType;
@dynamic userId;
@dynamic oldTitle;
@dynamic titleNew;
@dynamic oldStageId;
@dynamic stageIdNew;
@dynamic oldRoomId;
@dynamic roomIdNew;
@dynamic isAllRoomsNew;
@dynamic oldIsAllRooms;
@dynamic taskLog;

@end
