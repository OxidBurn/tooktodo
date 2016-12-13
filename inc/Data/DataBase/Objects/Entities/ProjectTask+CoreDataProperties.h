//
//  ProjectTask+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import "ProjectTask+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTask (CoreDataProperties)

+ (NSFetchRequest<ProjectTask *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *access;
@property (nullable, nonatomic, copy) NSNumber *attachments;
@property (nullable, nonatomic, copy) NSDate *closedDate;
@property (nullable, nonatomic, copy) NSNumber *commentsCount;
@property (nullable, nonatomic, copy) NSString *descriptionValue;
@property (nullable, nonatomic, copy) NSNumber *duration;
@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nullable, nonatomic, copy) NSNumber *extraId;
@property (nullable, nonatomic, copy) NSDate *factualEndDate;
@property (nullable, nonatomic, copy) NSDate *factualStartDate;
@property (nullable, nonatomic, copy) NSNumber *isAllRooms;
@property (nullable, nonatomic, copy) NSNumber *isExpired;
@property (nullable, nonatomic, copy) NSNumber *isIncludedRestDays;
@property (nullable, nonatomic, copy) NSNumber *isSelected;
@property (nullable, nonatomic, copy) NSNumber *isTaskStatusChanged;
@property (nullable, nonatomic, copy) NSNumber *isUrgent;
@property (nullable, nonatomic, copy) NSString *mapPreviewImage;
@property (nullable, nonatomic, copy) NSNumber *ownerUserId;
@property (nullable, nonatomic, copy) NSNumber *parentTaskId;
@property (nullable, nonatomic, copy) NSNumber *projectId;
@property (nullable, nonatomic, copy) NSNumber *projectRelatedId;
@property (nullable, nonatomic, copy) NSDate *startDay;
@property (nullable, nonatomic, copy) NSNumber *status;
@property (nullable, nonatomic, copy) NSString *statusDescription;
@property (nullable, nonatomic, copy) NSString *storageDirectoryId;
@property (nullable, nonatomic, copy) NSNumber *storageFilesCount;
@property (nullable, nonatomic, copy) NSNumber *taskAccess;
@property (nullable, nonatomic, copy) NSString *taskDescription;
@property (nullable, nonatomic, copy) NSNumber *taskID;
@property (nullable, nonatomic, copy) NSNumber *taskType;
@property (nullable, nonatomic, copy) NSString *taskTypeDescription;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) NSSet<TaskApprovments *> *approvments;
@property (nullable, nonatomic, retain) TaskAvailableActionsList *availableActions;
@property (nullable, nonatomic, retain) NSOrderedSet<TaskComment *> *comments;
@property (nullable, nonatomic, retain) NSOrderedSet<TaskLogInfo *> *logs;
@property (nullable, nonatomic, retain) ProjectTaskMarker *marker;
@property (nullable, nonatomic, retain) ProjectTaskOwner *ownerUser;
@property (nullable, nonatomic, retain) ProjectInfo *project;
@property (nullable, nonatomic, retain) ProjectTaskResponsible *responsible;
@property (nullable, nonatomic, retain) ProjectTaskRoom *room;
@property (nullable, nonatomic, retain) ProjectTaskRoomLevel *roomLevel;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskRoom *> *rooms;
@property (nullable, nonatomic, retain) ProjectTaskStage *stage;
@property (nullable, nonatomic, retain) NSSet<ProjectTask *> *subTasks;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskRoleAssignments *> *taskRoleAssignments;
@property (nullable, nonatomic, retain) ProjectTaskWorkArea *workArea;

@end

@interface ProjectTask (CoreDataGeneratedAccessors)

- (void)addApprovmentsObject:(TaskApprovments *)value;
- (void)removeApprovmentsObject:(TaskApprovments *)value;
- (void)addApprovments:(NSSet<TaskApprovments *> *)values;
- (void)removeApprovments:(NSSet<TaskApprovments *> *)values;

- (void)insertObject:(TaskComment *)value inCommentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCommentsAtIndex:(NSUInteger)idx;
- (void)insertComments:(NSArray<TaskComment *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCommentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCommentsAtIndex:(NSUInteger)idx withObject:(TaskComment *)value;
- (void)replaceCommentsAtIndexes:(NSIndexSet *)indexes withComments:(NSArray<TaskComment *> *)values;
- (void)addCommentsObject:(TaskComment *)value;
- (void)removeCommentsObject:(TaskComment *)value;
- (void)addComments:(NSOrderedSet<TaskComment *> *)values;
- (void)removeComments:(NSOrderedSet<TaskComment *> *)values;

- (void)insertObject:(TaskLogInfo *)value inLogsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromLogsAtIndex:(NSUInteger)idx;
- (void)insertLogs:(NSArray<TaskLogInfo *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeLogsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInLogsAtIndex:(NSUInteger)idx withObject:(TaskLogInfo *)value;
- (void)replaceLogsAtIndexes:(NSIndexSet *)indexes withLogs:(NSArray<TaskLogInfo *> *)values;
- (void)addLogsObject:(TaskLogInfo *)value;
- (void)removeLogsObject:(TaskLogInfo *)value;
- (void)addLogs:(NSOrderedSet<TaskLogInfo *> *)values;
- (void)removeLogs:(NSOrderedSet<TaskLogInfo *> *)values;

- (void)insertObject:(ProjectTaskRoom *)value inRoomsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRoomsAtIndex:(NSUInteger)idx;
- (void)insertRooms:(NSArray<ProjectTaskRoom *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRoomsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRoomsAtIndex:(NSUInteger)idx withObject:(ProjectTaskRoom *)value;
- (void)replaceRoomsAtIndexes:(NSIndexSet *)indexes withRooms:(NSArray<ProjectTaskRoom *> *)values;
- (void)addRoomsObject:(ProjectTaskRoom *)value;
- (void)removeRoomsObject:(ProjectTaskRoom *)value;
- (void)addRooms:(NSOrderedSet<ProjectTaskRoom *> *)values;
- (void)removeRooms:(NSOrderedSet<ProjectTaskRoom *> *)values;

- (void)addSubTasksObject:(ProjectTask *)value;
- (void)removeSubTasksObject:(ProjectTask *)value;
- (void)addSubTasks:(NSSet<ProjectTask *> *)values;
- (void)removeSubTasks:(NSSet<ProjectTask *> *)values;

- (void)insertObject:(ProjectTaskRoleAssignments *)value inTaskRoleAssignmentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTaskRoleAssignmentsAtIndex:(NSUInteger)idx;
- (void)insertTaskRoleAssignments:(NSArray<ProjectTaskRoleAssignments *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTaskRoleAssignmentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTaskRoleAssignmentsAtIndex:(NSUInteger)idx withObject:(ProjectTaskRoleAssignments *)value;
- (void)replaceTaskRoleAssignmentsAtIndexes:(NSIndexSet *)indexes withTaskRoleAssignments:(NSArray<ProjectTaskRoleAssignments *> *)values;
- (void)addTaskRoleAssignmentsObject:(ProjectTaskRoleAssignments *)value;
- (void)removeTaskRoleAssignmentsObject:(ProjectTaskRoleAssignments *)value;
- (void)addTaskRoleAssignments:(NSOrderedSet<ProjectTaskRoleAssignments *> *)values;
- (void)removeTaskRoleAssignments:(NSOrderedSet<ProjectTaskRoleAssignments *> *)values;

@end

NS_ASSUME_NONNULL_END
