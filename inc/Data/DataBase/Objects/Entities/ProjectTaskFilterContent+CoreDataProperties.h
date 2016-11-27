//
//  ProjectTaskFilterContent+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/27/16.
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
@property (nullable, nonatomic, retain) NSSet<ProjectTaskAssignee *> *creators;
@property (nullable, nonatomic, retain) ProjectInfo *project;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskAssignee *> *responsibles;
@property (nullable, nonatomic, retain) NSSet<ProjectSystem *> *systems;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskWorkArea *> *workArea;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskAssignee *> *approvementsAssignee;
@property (nullable, nonatomic, retain) NSSet<ProjectInviteInfo *> *approvementsInvite;

@end

@interface ProjectTaskFilterContent (CoreDataGeneratedAccessors)

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

- (void)addApprovementsAssigneeObject:(ProjectTaskAssignee *)value;
- (void)removeApprovementsAssigneeObject:(ProjectTaskAssignee *)value;
- (void)addApprovementsAssignee:(NSSet<ProjectTaskAssignee *> *)values;
- (void)removeApprovementsAssignee:(NSSet<ProjectTaskAssignee *> *)values;

- (void)addApprovementsInviteObject:(ProjectInviteInfo *)value;
- (void)removeApprovementsInviteObject:(ProjectInviteInfo *)value;
- (void)addApprovementsInvite:(NSSet<ProjectInviteInfo *> *)values;
- (void)removeApprovementsInvite:(NSSet<ProjectInviteInfo *> *)values;

@end

NS_ASSUME_NONNULL_END
