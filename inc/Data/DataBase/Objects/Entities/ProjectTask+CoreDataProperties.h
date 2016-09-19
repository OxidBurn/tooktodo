//
//  ProjectTask+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/18/16.
//
//

#import "ProjectTask+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTask (CoreDataProperties)

+ (NSFetchRequest<ProjectTask *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *access;
@property (nullable, nonatomic, copy) NSDate *closedDate;
@property (nullable, nonatomic, copy) NSString *descriptionValue;
@property (nullable, nonatomic, copy) NSNumber *duration;
@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nullable, nonatomic, copy) NSNumber *extraId;
@property (nullable, nonatomic, copy) NSNumber *isAllRooms;
@property (nullable, nonatomic, copy) NSNumber *isExpired;
@property (nullable, nonatomic, copy) NSNumber *isIncludedRestDays;
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
@property (nullable, nonatomic, copy) NSNumber *attachments;
@property (nullable, nonatomic, retain) ProjectTaskMarker *marker;
@property (nullable, nonatomic, retain) ProjectTaskOwner *ownerUser;
@property (nullable, nonatomic, retain) ProjectInfo *project;
@property (nullable, nonatomic, retain) ProjectTaskResponsible *responsible;
@property (nullable, nonatomic, retain) ProjectTaskRoomLevel *roomLevel;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskRoom *> *rooms;
@property (nullable, nonatomic, retain) ProjectTaskStage *stage;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskSubTasks *> *subTasks;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskRoleAssignments *> *taskRoleAssignments;
@property (nullable, nonatomic, retain) ProjectTaskWorkArea *workArea;
@property (nullable, nonatomic, retain) ProjectTaskRoom *room;

@end

@interface ProjectTask (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(ProjectTaskRoom *)value;
- (void)removeRoomsObject:(ProjectTaskRoom *)value;
- (void)addRooms:(NSSet<ProjectTaskRoom *> *)values;
- (void)removeRooms:(NSSet<ProjectTaskRoom *> *)values;

- (void)addSubTasksObject:(ProjectTaskSubTasks *)value;
- (void)removeSubTasksObject:(ProjectTaskSubTasks *)value;
- (void)addSubTasks:(NSSet<ProjectTaskSubTasks *> *)values;
- (void)removeSubTasks:(NSSet<ProjectTaskSubTasks *> *)values;

- (void)addTaskRoleAssignmentsObject:(ProjectTaskRoleAssignments *)value;
- (void)removeTaskRoleAssignmentsObject:(ProjectTaskRoleAssignments *)value;
- (void)addTaskRoleAssignments:(NSSet<ProjectTaskRoleAssignments *> *)values;
- (void)removeTaskRoleAssignments:(NSSet<ProjectTaskRoleAssignments *> *)values;

@end

NS_ASSUME_NONNULL_END