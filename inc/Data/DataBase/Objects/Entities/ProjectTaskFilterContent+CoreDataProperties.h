//
//  ProjectTaskFilterContent+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/25/16.
//
//

#import "ProjectTaskFilterContent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskFilterContent (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskFilterContent *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nullable, nonatomic, copy) NSDate *factualEndDate;
@property (nullable, nonatomic, copy) NSDate *factualStartDate;
@property (nullable, nonatomic, copy) NSNumber *isCanceled;
@property (nullable, nonatomic, copy) NSNumber *isDone;
@property (nullable, nonatomic, copy) NSNumber *isExpired;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, retain) NSObject *statuses;
@property (nullable, nonatomic, retain) NSObject *types;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskAssignee *> *approvements;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskAssignee *> *creators;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskAssignee *> *responsibles;
@property (nullable, nonatomic, retain) NSSet<ProjectSystem *> *systems;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskWorkArea *> *workArea;
@property (nullable, nonatomic, retain) ProjectInfo *project;

@end

@interface ProjectTaskFilterContent (CoreDataGeneratedAccessors)

- (void)insertObject:(ProjectTaskAssignee *)value inApprovementsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromApprovementsAtIndex:(NSUInteger)idx;
- (void)insertApprovements:(NSArray<ProjectTaskAssignee *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeApprovementsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInApprovementsAtIndex:(NSUInteger)idx withObject:(ProjectTaskAssignee *)value;
- (void)replaceApprovementsAtIndexes:(NSIndexSet *)indexes withApprovements:(NSArray<ProjectTaskAssignee *> *)values;
- (void)addApprovementsObject:(ProjectTaskAssignee *)value;
- (void)removeApprovementsObject:(ProjectTaskAssignee *)value;
- (void)addApprovements:(NSOrderedSet<ProjectTaskAssignee *> *)values;
- (void)removeApprovements:(NSOrderedSet<ProjectTaskAssignee *> *)values;

- (void)addCreatorsObject:(ProjectTaskAssignee *)value;
- (void)removeCreatorsObject:(ProjectTaskAssignee *)value;
- (void)addCreators:(NSSet<ProjectTaskAssignee *> *)values;
- (void)removeCreators:(NSSet<ProjectTaskAssignee *> *)values;

- (void)addResponsiblesObject:(ProjectTaskAssignee *)value;
- (void)removeResponsiblesObject:(ProjectTaskAssignee *)value;
- (void)addResponsibles:(NSSet<ProjectTaskAssignee *> *)values;
- (void)removeResponsibles:(NSSet<ProjectTaskAssignee *> *)values;

- (void)addSystemsObject:(ProjectSystem *)value;
- (void)removeSystemsObject:(ProjectSystem *)value;
- (void)addSystems:(NSSet<ProjectSystem *> *)values;
- (void)removeSystems:(NSSet<ProjectSystem *> *)values;

- (void)addWorkAreaObject:(ProjectTaskWorkArea *)value;
- (void)removeWorkAreaObject:(ProjectTaskWorkArea *)value;
- (void)addWorkArea:(NSSet<ProjectTaskWorkArea *> *)values;
- (void)removeWorkArea:(NSSet<ProjectTaskWorkArea *> *)values;

@end

NS_ASSUME_NONNULL_END
