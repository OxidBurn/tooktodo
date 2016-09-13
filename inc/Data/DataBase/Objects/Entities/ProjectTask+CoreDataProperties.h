//
//  ProjectTask+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectTask.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTask (CoreDataProperties)

@property (nullable, nonatomic, retain) NSDate                     *closedDate;
@property (nullable, nonatomic, retain) NSString                   *descriptionValue;
@property (nullable, nonatomic, retain) NSNumber                   *duration;
@property (nullable, nonatomic, retain) NSDate                     *endDate;
@property (nullable, nonatomic, retain) NSNumber                   *extraId;
@property (nullable, nonatomic, retain) NSNumber                   *isAllRooms;
@property (nullable, nonatomic, retain) NSNumber                   *isExpired;
@property (nullable, nonatomic, retain) NSNumber                   *isIncludedRestDays;
@property (nullable, nonatomic, retain) NSNumber                   *isTaskStatusChanged;
@property (nullable, nonatomic, retain) NSNumber                   *isUrgent;
@property (nullable, nonatomic, retain) NSString                   *mapPreviewImage;
@property (nullable, nonatomic, retain) NSNumber                   *ownerUserId;
@property (nullable, nonatomic, retain) NSNumber                   *parentTaskId;
@property (nullable, nonatomic, retain) NSNumber                   *projectId;
@property (nullable, nonatomic, retain) NSNumber                   *projectRelatedId;
@property (nullable, nonatomic, retain) NSNumber                   *status;
@property (nullable, nonatomic, retain) NSString                   *statusDescription;
@property (nullable, nonatomic, retain) NSString                   *storageDirectoryId;
@property (nullable, nonatomic, retain) NSNumber                   *storageFilesCount;
@property (nullable, nonatomic, retain) NSNumber                   *taskAccess;
@property (nullable, nonatomic, retain) NSNumber                   *taskID;
@property (nullable, nonatomic, retain) NSNumber                   *taskType;
@property (nullable, nonatomic, retain) NSString                   *taskTypeDescription;
@property (nullable, nonatomic, retain) NSString                   *title;
@property (nullable, nonatomic, retain) ProjectTaskResponsible     *responsible;
@property (nullable, nonatomic, retain) ProjectTaskStage           *stage;
@property (nullable, nonatomic, retain) ProjectTaskWorkArea        *workArea;
@property (nullable, nonatomic, retain) ProjectTaskOwner           *ownerUser;
@property (nullable, nonatomic, retain) ProjectTaskMarker          *marker;
@property (nullable, nonatomic, retain) ProjectTaskRoomLevel       *roomLevel;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskRoom            *> *rooms;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskSubTasks        *> *subTasks;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskRoleAssignments *> *taskRoleAssignments;
@property (nullable, nonatomic, retain) ProjectInfo *project;

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
