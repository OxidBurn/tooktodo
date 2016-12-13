//
//  TaskLogDataContent+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/23/16.
//
//

#import "TaskLogDataContent+CoreDataProperties.h"

@implementation TaskLogDataContent (CoreDataProperties)

+ (NSFetchRequest<TaskLogDataContent *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskLogDataContent"];
}

@dynamic commentId;
@dynamic oldStartDate;
@dynamic oldEndDate;
@dynamic newStartDate;
@dynamic newEndDate;
@dynamic oldStatus;
@dynamic newStatus;
@dynamic fileTitles;
@dynamic fileTitlesWithExtensions;
@dynamic storageFiles;
@dynamic oldValue;
@dynamic newValue;
@dynamic userId;
@dynamic projectRoleAssignmentId;
@dynamic taskRoleType;
@dynamic oldDescription;
@dynamic newDescription;
@dynamic oldWorkArea;
@dynamic newWorkArea;
@dynamic taskLog;

@end
