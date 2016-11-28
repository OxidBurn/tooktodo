//
//  ProjectTaskRoleAssignment+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import "ProjectTaskRoleAssignment+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoleAssignment (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoleAssignment *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *isBlocked;
@property (nullable, nonatomic, copy) NSNumber *projectPermission;
@property (nullable, nonatomic, copy) NSNumber *taskRoleAssignmnetID;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskAssignee *> *assignee;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectInviteInfo *> *invite;
@property (nullable, nonatomic, retain) ProjectTaskRoleAssignments *projectRoleAssignments;
@property (nullable, nonatomic, retain) ProjectTaskRoleType *projectRoleType;

@end

@interface ProjectTaskRoleAssignment (CoreDataGeneratedAccessors)

- (void)insertObject:(ProjectTaskAssignee *)value inAssigneeAtIndex:(NSUInteger)idx;
- (void)removeObjectFromAssigneeAtIndex:(NSUInteger)idx;
- (void)insertAssignee:(NSArray<ProjectTaskAssignee *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeAssigneeAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInAssigneeAtIndex:(NSUInteger)idx withObject:(ProjectTaskAssignee *)value;
- (void)replaceAssigneeAtIndexes:(NSIndexSet *)indexes withAssignee:(NSArray<ProjectTaskAssignee *> *)values;
- (void)addAssigneeObject:(ProjectTaskAssignee *)value;
- (void)removeAssigneeObject:(ProjectTaskAssignee *)value;
- (void)addAssignee:(NSOrderedSet<ProjectTaskAssignee *> *)values;
- (void)removeAssignee:(NSOrderedSet<ProjectTaskAssignee *> *)values;

- (void)insertObject:(ProjectInviteInfo *)value inInviteAtIndex:(NSUInteger)idx;
- (void)removeObjectFromInviteAtIndex:(NSUInteger)idx;
- (void)insertInvite:(NSArray<ProjectInviteInfo *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeInviteAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInInviteAtIndex:(NSUInteger)idx withObject:(ProjectInviteInfo *)value;
- (void)replaceInviteAtIndexes:(NSIndexSet *)indexes withInvite:(NSArray<ProjectInviteInfo *> *)values;
- (void)addInviteObject:(ProjectInviteInfo *)value;
- (void)removeInviteObject:(ProjectInviteInfo *)value;
- (void)addInvite:(NSOrderedSet<ProjectInviteInfo *> *)values;
- (void)removeInvite:(NSOrderedSet<ProjectInviteInfo *> *)values;

@end

NS_ASSUME_NONNULL_END
