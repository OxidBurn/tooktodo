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
@property (nullable, nonatomic, retain) NSObject *roomsSelectedIndexes;
@property (nullable, nonatomic, copy) NSDate *startBeginDate;
@property (nullable, nonatomic, copy) NSDate *startEndDate;
@property (nullable, nonatomic, retain) NSObject *statuses;
@property (nullable, nonatomic, retain) NSObject *workAreasSelectedIndexes;
@property (nullable, nonatomic, retain) NSObject *types;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskAssignee *> *approvementsAssignee;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectInviteInfo *> *approvementsInvite;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskAssignee *> *creators;
@property (nullable, nonatomic, retain) ProjectInfo *project;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskAssignee *> *responsibles;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskRoom *> *rooms;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskWorkArea *> *workAreas;

@end

@interface ProjectTaskFilterContent (CoreDataGeneratedAccessors)

- (void)insertObject:(ProjectTaskAssignee *)value inApprovementsAssigneeAtIndex:(NSUInteger)idx;
- (void)removeObjectFromApprovementsAssigneeAtIndex:(NSUInteger)idx;
- (void)insertApprovementsAssignee:(NSArray<ProjectTaskAssignee *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeApprovementsAssigneeAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInApprovementsAssigneeAtIndex:(NSUInteger)idx withObject:(ProjectTaskAssignee *)value;
- (void)replaceApprovementsAssigneeAtIndexes:(NSIndexSet *)indexes withApprovementsAssignee:(NSArray<ProjectTaskAssignee *> *)values;
- (void)addApprovementsAssigneeObject:(ProjectTaskAssignee *)value;
- (void)removeApprovementsAssigneeObject:(ProjectTaskAssignee *)value;
- (void)addApprovementsAssignee:(NSOrderedSet<ProjectTaskAssignee *> *)values;
- (void)removeApprovementsAssignee:(NSOrderedSet<ProjectTaskAssignee *> *)values;

- (void)insertObject:(ProjectInviteInfo *)value inApprovementsInviteAtIndex:(NSUInteger)idx;
- (void)removeObjectFromApprovementsInviteAtIndex:(NSUInteger)idx;
- (void)insertApprovementsInvite:(NSArray<ProjectInviteInfo *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeApprovementsInviteAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInApprovementsInviteAtIndex:(NSUInteger)idx withObject:(ProjectInviteInfo *)value;
- (void)replaceApprovementsInviteAtIndexes:(NSIndexSet *)indexes withApprovementsInvite:(NSArray<ProjectInviteInfo *> *)values;
- (void)addApprovementsInviteObject:(ProjectInviteInfo *)value;
- (void)removeApprovementsInviteObject:(ProjectInviteInfo *)value;
- (void)addApprovementsInvite:(NSOrderedSet<ProjectInviteInfo *> *)values;
- (void)removeApprovementsInvite:(NSOrderedSet<ProjectInviteInfo *> *)values;

- (void)insertObject:(ProjectTaskAssignee *)value inCreatorsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromCreatorsAtIndex:(NSUInteger)idx;
- (void)insertCreators:(NSArray<ProjectTaskAssignee *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeCreatorsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInCreatorsAtIndex:(NSUInteger)idx withObject:(ProjectTaskAssignee *)value;
- (void)replaceCreatorsAtIndexes:(NSIndexSet *)indexes withCreators:(NSArray<ProjectTaskAssignee *> *)values;
- (void)addCreatorsObject:(ProjectTaskAssignee *)value;
- (void)removeCreatorsObject:(ProjectTaskAssignee *)value;
- (void)addCreators:(NSOrderedSet<ProjectTaskAssignee *> *)values;
- (void)removeCreators:(NSOrderedSet<ProjectTaskAssignee *> *)values;

- (void)insertObject:(ProjectTaskAssignee *)value inResponsiblesAtIndex:(NSUInteger)idx;
- (void)removeObjectFromResponsiblesAtIndex:(NSUInteger)idx;
- (void)insertResponsibles:(NSArray<ProjectTaskAssignee *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeResponsiblesAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInResponsiblesAtIndex:(NSUInteger)idx withObject:(ProjectTaskAssignee *)value;
- (void)replaceResponsiblesAtIndexes:(NSIndexSet *)indexes withResponsibles:(NSArray<ProjectTaskAssignee *> *)values;
- (void)addResponsiblesObject:(ProjectTaskAssignee *)value;
- (void)removeResponsiblesObject:(ProjectTaskAssignee *)value;
- (void)addResponsibles:(NSOrderedSet<ProjectTaskAssignee *> *)values;
- (void)removeResponsibles:(NSOrderedSet<ProjectTaskAssignee *> *)values;

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

- (void)insertObject:(ProjectTaskWorkArea *)value inWorkAreasAtIndex:(NSUInteger)idx;
- (void)removeObjectFromWorkAreasAtIndex:(NSUInteger)idx;
- (void)insertWorkAreas:(NSArray<ProjectTaskWorkArea *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeWorkAreasAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInWorkAreasAtIndex:(NSUInteger)idx withObject:(ProjectTaskWorkArea *)value;
- (void)replaceWorkAreasAtIndexes:(NSIndexSet *)indexes withWorkAreas:(NSArray<ProjectTaskWorkArea *> *)values;
- (void)addWorkAreasObject:(ProjectTaskWorkArea *)value;
- (void)removeWorkAreasObject:(ProjectTaskWorkArea *)value;
- (void)addWorkAreas:(NSOrderedSet<ProjectTaskWorkArea *> *)values;
- (void)removeWorkAreas:(NSOrderedSet<ProjectTaskWorkArea *> *)values;

@end

NS_ASSUME_NONNULL_END
