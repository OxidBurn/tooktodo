//
//  ProjectInfo+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 10/4/16.
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
@property (nullable, nonatomic, retain) NSSet<OfflineSettings *> *offlineSettings;
@property (nullable, nonatomic, retain) NSSet<ProjectRoleAssignments *> *projectRoleAssignments;
@property (nullable, nonatomic, retain) ProjectRegion *region;
@property (nullable, nonatomic, retain) NSSet<ProjectRoles *> *roles;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskStage *> *stage;
@property (nullable, nonatomic, retain) NSSet<ProjectSystem *> *systems;
@property (nullable, nonatomic, retain) NSSet<ProjectTask *> *tasks;
@property (nullable, nonatomic, retain) NSSet<TeamMember *> *team;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskRoomLevel *> *roomLevel;

@end

@interface ProjectInfo (CoreDataGeneratedAccessors)

- (void)addOfflineSettingsObject:(OfflineSettings *)value;
- (void)removeOfflineSettingsObject:(OfflineSettings *)value;
- (void)addOfflineSettings:(NSSet<OfflineSettings *> *)values;
- (void)removeOfflineSettings:(NSSet<OfflineSettings *> *)values;

- (void)addProjectRoleAssignmentsObject:(ProjectRoleAssignments *)value;
- (void)removeProjectRoleAssignmentsObject:(ProjectRoleAssignments *)value;
- (void)addProjectRoleAssignments:(NSSet<ProjectRoleAssignments *> *)values;
- (void)removeProjectRoleAssignments:(NSSet<ProjectRoleAssignments *> *)values;

- (void)addRolesObject:(ProjectRoles *)value;
- (void)removeRolesObject:(ProjectRoles *)value;
- (void)addRoles:(NSSet<ProjectRoles *> *)values;
- (void)removeRoles:(NSSet<ProjectRoles *> *)values;

- (void)addStageObject:(ProjectTaskStage *)value;
- (void)removeStageObject:(ProjectTaskStage *)value;
- (void)addStage:(NSSet<ProjectTaskStage *> *)values;
- (void)removeStage:(NSSet<ProjectTaskStage *> *)values;

- (void)addSystemsObject:(ProjectSystem *)value;
- (void)removeSystemsObject:(ProjectSystem *)value;
- (void)addSystems:(NSSet<ProjectSystem *> *)values;
- (void)removeSystems:(NSSet<ProjectSystem *> *)values;

- (void)addTasksObject:(ProjectTask *)value;
- (void)removeTasksObject:(ProjectTask *)value;
- (void)addTasks:(NSSet<ProjectTask *> *)values;
- (void)removeTasks:(NSSet<ProjectTask *> *)values;

- (void)addTeamObject:(TeamMember *)value;
- (void)removeTeamObject:(TeamMember *)value;
- (void)addTeam:(NSSet<TeamMember *> *)values;
- (void)removeTeam:(NSSet<TeamMember *> *)values;

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

@end

NS_ASSUME_NONNULL_END
