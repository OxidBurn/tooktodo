//
//  ProjectTaskFilterContent+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import "ProjectTaskFilterContent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskFilterContent (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskFilterContent *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *approvementsSelectedIndexes;
@property (nullable, nonatomic, copy) NSDate *closeBeginDate;
@property (nullable, nonatomic, copy) NSDate *closeEndDate;
@property (nullable, nonatomic, retain) NSObject *creatorsSelectedIndexes;
@property (nullable, nonatomic, copy) NSDate *factualCloseBeginDate;
@property (nullable, nonatomic, copy) NSDate *factualCloseEndDate;
@property (nullable, nonatomic, copy) NSDate *factualStartBeginDate;
@property (nullable, nonatomic, copy) NSDate *factualStartEndDate;
@property (nullable, nonatomic, copy) NSNumber *isCanceled;
@property (nullable, nonatomic, copy) NSNumber *isDone;
@property (nullable, nonatomic, copy) NSNumber *isExpired;
@property (nullable, nonatomic, retain) NSObject *responsiblesSelectedIndexes;
@property (nullable, nonatomic, copy) NSDate *startBeginDate;
@property (nullable, nonatomic, copy) NSDate *startEndDate;
@property (nullable, nonatomic, retain) NSObject *statuses;
@property (nullable, nonatomic, retain) NSObject *types;
@property (nullable, nonatomic, retain) NSObject *roomsSelectedIndexes;
@property (nullable, nonatomic, retain) NSObject *workAreasSelectedIndexes;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskAssignee *> *approvementsAssignee;
@property (nullable, nonatomic, retain) NSSet<ProjectInviteInfo *> *approvementsInvite;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskAssignee *> *creators;
@property (nullable, nonatomic, retain) ProjectInfo *project;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskAssignee *> *responsibles;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskWorkArea *> *workAreas;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskRoom *> *rooms;

@end

@interface ProjectTaskFilterContent (CoreDataGeneratedAccessors)

- (void)addApprovementsAssigneeObject:(ProjectTaskAssignee *)value;
- (void)removeApprovementsAssigneeObject:(ProjectTaskAssignee *)value;
- (void)addApprovementsAssignee:(NSSet<ProjectTaskAssignee *> *)values;
- (void)removeApprovementsAssignee:(NSSet<ProjectTaskAssignee *> *)values;

- (void)addApprovementsInviteObject:(ProjectInviteInfo *)value;
- (void)removeApprovementsInviteObject:(ProjectInviteInfo *)value;
- (void)addApprovementsInvite:(NSSet<ProjectInviteInfo *> *)values;
- (void)removeApprovementsInvite:(NSSet<ProjectInviteInfo *> *)values;

- (void)addCreatorsObject:(ProjectTaskAssignee *)value;
- (void)removeCreatorsObject:(ProjectTaskAssignee *)value;
- (void)addCreators:(NSSet<ProjectTaskAssignee *> *)values;
- (void)removeCreators:(NSSet<ProjectTaskAssignee *> *)values;

- (void)addResponsiblesObject:(ProjectTaskAssignee *)value;
- (void)removeResponsiblesObject:(ProjectTaskAssignee *)value;
- (void)addResponsibles:(NSSet<ProjectTaskAssignee *> *)values;
- (void)removeResponsibles:(NSSet<ProjectTaskAssignee *> *)values;

- (void)addWorkAreasObject:(ProjectTaskWorkArea *)value;
- (void)removeWorkAreasObject:(ProjectTaskWorkArea *)value;
- (void)addWorkAreas:(NSSet<ProjectTaskWorkArea *> *)values;
- (void)removeWorkAreas:(NSSet<ProjectTaskWorkArea *> *)values;

- (void)addRoomsObject:(ProjectTaskRoom *)value;
- (void)removeRoomsObject:(ProjectTaskRoom *)value;
- (void)addRooms:(NSSet<ProjectTaskRoom *> *)values;
- (void)removeRooms:(NSSet<ProjectTaskRoom *> *)values;

@end

NS_ASSUME_NONNULL_END
