//
//  TaskLogDataContent+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 12/23/16.
//
//

#import "TaskLogDataContent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskLogDataContent (CoreDataProperties)

+ (NSFetchRequest<TaskLogDataContent *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *commentId;
@property (nullable, nonatomic, retain) NSObject *fileTitles;
@property (nullable, nonatomic, retain) NSObject *fileTitlesWithExtensions;
@property (nullable, nonatomic, copy) NSString *newDescription;
@property (nullable, nonatomic, copy) NSDate *newEndDate;
@property (nullable, nonatomic, copy) NSDate *newStartDate;
@property (nullable, nonatomic, copy) NSNumber *newStatus;
@property (nullable, nonatomic, copy) NSNumber *newValue;
@property (nullable, nonatomic, copy) NSNumber *newWorkArea;
@property (nullable, nonatomic, copy) NSString *oldDescription;
@property (nullable, nonatomic, copy) NSDate *oldEndDate;
@property (nullable, nonatomic, copy) NSDate *oldStartDate;
@property (nullable, nonatomic, copy) NSNumber *oldStatus;
@property (nullable, nonatomic, copy) NSNumber *oldValue;
@property (nullable, nonatomic, copy) NSNumber *oldWorkArea;
@property (nullable, nonatomic, copy) NSNumber *projectRoleAssignmentId;
@property (nullable, nonatomic, retain) NSObject *storageFiles;
@property (nullable, nonatomic, copy) NSNumber *taskRoleType;
@property (nullable, nonatomic, copy) NSNumber *userId;
@property (nullable, nonatomic, copy) NSString *oldTitle;
@property (nullable, nonatomic, copy) NSString *titleNew;
@property (nullable, nonatomic, copy) NSNumber *oldStageId;
@property (nullable, nonatomic, copy) NSNumber *stageIdNew;
@property (nullable, nonatomic, copy) NSNumber *oldRoomId;
@property (nullable, nonatomic, copy) NSNumber *roomIdNew;
@property (nullable, nonatomic, copy) NSNumber *isAllRoomsNew;
@property (nullable, nonatomic, copy) NSNumber *oldIsAllRooms;
@property (nullable, nonatomic, copy) NSNumber *oldType;
@property (nullable, nonatomic, copy) NSNumber *typeNew;
@property (nullable, nonatomic, retain) TaskLogInfo *taskLog;

@end

NS_ASSUME_NONNULL_END
