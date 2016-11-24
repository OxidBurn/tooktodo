//
//  ProjectTaskRoleAssignment+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 24.11.16.
//
//

#import "ProjectTaskRoleAssignment+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoleAssignment (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoleAssignment *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *isBlocked;
@property (nullable, nonatomic, copy) NSNumber *projectPermission;
@property (nullable, nonatomic, copy) NSNumber *taskRoleAssignmnetID;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskAssignee *> *assignee;
@property (nullable, nonatomic, retain) NSSet<ProjectInviteInfo *> *invite;
@property (nullable, nonatomic, retain) ProjectTaskRoleAssignments *projectRoleAssignments;
@property (nullable, nonatomic, retain) ProjectTaskRoleType *projectRoleType;

@end

@interface ProjectTaskRoleAssignment (CoreDataGeneratedAccessors)

- (void)addAssigneeObject:(ProjectTaskAssignee *)value;
- (void)removeAssigneeObject:(ProjectTaskAssignee *)value;
- (void)addAssignee:(NSSet<ProjectTaskAssignee *> *)values;
- (void)removeAssignee:(NSSet<ProjectTaskAssignee *> *)values;

- (void)addInviteObject:(ProjectInviteInfo *)value;
- (void)removeInviteObject:(ProjectInviteInfo *)value;
- (void)addInvite:(NSSet<ProjectInviteInfo *> *)values;
- (void)removeInvite:(NSSet<ProjectInviteInfo *> *)values;

@end

NS_ASSUME_NONNULL_END
