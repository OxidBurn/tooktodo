//
//  ProjectInfo+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import "ProjectInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectInfo (CoreDataProperties)

+ (NSFetchRequest<ProjectInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *apartment;
@property (nullable, nonatomic, copy) NSString *building;
@property (nullable, nonatomic, copy) NSString *city;
@property (nullable, nonatomic, copy) NSNumber *commercialObjectType;
@property (nullable, nonatomic, copy) NSString *commercialObjectTypeDescription;
@property (nullable, nonatomic, copy) NSDate *createdDate;
@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nullable, nonatomic, copy) NSNumber *floor;
@property (nullable, nonatomic, copy) NSString *info;
@property (nullable, nonatomic, copy) NSNumber *isExpanded;
@property (nullable, nonatomic, copy) NSNumber *isRolesInvitationAppealClosed;
@property (nullable, nonatomic, copy) NSNumber *isSelected;
@property (nullable, nonatomic, copy) NSNumber *isTaskAddAppealClosed;
@property (nullable, nonatomic, copy) NSDate *lastVisit;
@property (nullable, nonatomic, copy) NSNumber *ownerUserId;
@property (nullable, nonatomic, copy) NSString *phoneNumber;
@property (nullable, nonatomic, copy) NSNumber *projectID;
@property (nullable, nonatomic, copy) NSNumber *projectPermission;
@property (nullable, nonatomic, copy) NSNumber *realtyClass;
@property (nullable, nonatomic, copy) NSString *realtyClassDescription;
@property (nullable, nonatomic, copy) NSString *regionName;
@property (nullable, nonatomic, copy) NSNumber *residentialObjectType;
@property (nullable, nonatomic, copy) NSString *residentialObjectTypeDescription;
@property (nullable, nonatomic, copy) NSString *street;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) ProjectCountry *country;
@property (nullable, nonatomic, retain) ProjectFilterInfo *filters;
@property (nullable, nonatomic, retain) NSSet<OfflineSettings *> *offlineSettings;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectRoleAssignments *> *projectRoleAssignments;
@property (nullable, nonatomic, retain) ProjectRegion *region;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectRoles *> *roles;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskRoomLevel *> *roomLevel;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskStage *> *stage;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectSystem *> *systems;
@property (nullable, nonatomic, retain) ProjectTaskFilterContent *taskFilterConfig;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTask *> *tasks;
@property (nullable, nonatomic, retain) NSOrderedSet<TeamMember *> *team;

@end

@interface ProjectInfo (CoreDataGeneratedAccessors)

- (void)addOfflineSettingsObject:(OfflineSettings *)value;
- (void)removeOfflineSettingsObject:(OfflineSettings *)value;
- (void)addOfflineSettings:(NSSet<OfflineSettings *> *)values;
- (void)removeOfflineSettings:(NSSet<OfflineSettings *> *)values;

- (void)insertObject:(ProjectRoleAssignments *)value inProjectRoleAssignmentsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromProjectRoleAssignmentsAtIndex:(NSUInteger)idx;
- (void)insertProjectRoleAssignments:(NSArray<ProjectRoleAssignments *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeProjectRoleAssignmentsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInProjectRoleAssignmentsAtIndex:(NSUInteger)idx withObject:(ProjectRoleAssignments *)value;
- (void)replaceProjectRoleAssignmentsAtIndexes:(NSIndexSet *)indexes withProjectRoleAssignments:(NSArray<ProjectRoleAssignments *> *)values;
- (void)addProjectRoleAssignmentsObject:(ProjectRoleAssignments *)value;
- (void)removeProjectRoleAssignmentsObject:(ProjectRoleAssignments *)value;
- (void)addProjectRoleAssignments:(NSOrderedSet<ProjectRoleAssignments *> *)values;
- (void)removeProjectRoleAssignments:(NSOrderedSet<ProjectRoleAssignments *> *)values;

- (void)insertObject:(ProjectRoles *)value inRolesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRolesAtIndex:(NSUInteger)idx;
- (void)insertRoles:(NSArray<ProjectRoles *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRolesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRolesAtIndex:(NSUInteger)idx withObject:(ProjectRoles *)value;
- (void)replaceRolesAtIndexes:(NSIndexSet *)indexes withRoles:(NSArray<ProjectRoles *> *)values;
- (void)addRolesObject:(ProjectRoles *)value;
- (void)removeRolesObject:(ProjectRoles *)value;
- (void)addRoles:(NSOrderedSet<ProjectRoles *> *)values;
- (void)removeRoles:(NSOrderedSet<ProjectRoles *> *)values;

- (void)insertObject:(ProjectTaskRoomLevel *)value inRoomLevelAtIndex:(NSUInteger)idx;
- (void)removeObjectFromRoomLevelAtIndex:(NSUInteger)idx;
- (void)insertRoomLevel:(NSArray<ProjectTaskRoomLevel *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeRoomLevelAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInRoomLevelAtIndex:(NSUInteger)idx withObject:(ProjectTaskRoomLevel *)value;
- (void)replaceRoomLevelAtIndexes:(NSIndexSet *)indexes withRoomLevel:(NSArray<ProjectTaskRoomLevel *> *)values;
- (void)addRoomLevelObject:(ProjectTaskRoomLevel *)value;
- (void)removeRoomLevelObject:(ProjectTaskRoomLevel *)value;
- (void)addRoomLevel:(NSOrderedSet<ProjectTaskRoomLevel *> *)values;
- (void)removeRoomLevel:(NSOrderedSet<ProjectTaskRoomLevel *> *)values;

- (void)insertObject:(ProjectTaskStage *)value inStageAtIndex:(NSUInteger)idx;
- (void)removeObjectFromStageAtIndex:(NSUInteger)idx;
- (void)insertStage:(NSArray<ProjectTaskStage *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeStageAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInStageAtIndex:(NSUInteger)idx withObject:(ProjectTaskStage *)value;
- (void)replaceStageAtIndexes:(NSIndexSet *)indexes withStage:(NSArray<ProjectTaskStage *> *)values;
- (void)addStageObject:(ProjectTaskStage *)value;
- (void)removeStageObject:(ProjectTaskStage *)value;
- (void)addStage:(NSOrderedSet<ProjectTaskStage *> *)values;
- (void)removeStage:(NSOrderedSet<ProjectTaskStage *> *)values;

- (void)insertObject:(ProjectSystem *)value inSystemsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromSystemsAtIndex:(NSUInteger)idx;
- (void)insertSystems:(NSArray<ProjectSystem *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeSystemsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInSystemsAtIndex:(NSUInteger)idx withObject:(ProjectSystem *)value;
- (void)replaceSystemsAtIndexes:(NSIndexSet *)indexes withSystems:(NSArray<ProjectSystem *> *)values;
- (void)addSystemsObject:(ProjectSystem *)value;
- (void)removeSystemsObject:(ProjectSystem *)value;
- (void)addSystems:(NSOrderedSet<ProjectSystem *> *)values;
- (void)removeSystems:(NSOrderedSet<ProjectSystem *> *)values;

- (void)insertObject:(ProjectTask *)value inTasksAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTasksAtIndex:(NSUInteger)idx;
- (void)insertTasks:(NSArray<ProjectTask *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTasksAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTasksAtIndex:(NSUInteger)idx withObject:(ProjectTask *)value;
- (void)replaceTasksAtIndexes:(NSIndexSet *)indexes withTasks:(NSArray<ProjectTask *> *)values;
- (void)addTasksObject:(ProjectTask *)value;
- (void)removeTasksObject:(ProjectTask *)value;
- (void)addTasks:(NSOrderedSet<ProjectTask *> *)values;
- (void)removeTasks:(NSOrderedSet<ProjectTask *> *)values;

- (void)insertObject:(TeamMember *)value inTeamAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTeamAtIndex:(NSUInteger)idx;
- (void)insertTeam:(NSArray<TeamMember *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTeamAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTeamAtIndex:(NSUInteger)idx withObject:(TeamMember *)value;
- (void)replaceTeamAtIndexes:(NSIndexSet *)indexes withTeam:(NSArray<TeamMember *> *)values;
- (void)addTeamObject:(TeamMember *)value;
- (void)removeTeamObject:(TeamMember *)value;
- (void)addTeam:(NSOrderedSet<TeamMember *> *)values;
- (void)removeTeam:(NSOrderedSet<TeamMember *> *)values;

@end

NS_ASSUME_NONNULL_END
