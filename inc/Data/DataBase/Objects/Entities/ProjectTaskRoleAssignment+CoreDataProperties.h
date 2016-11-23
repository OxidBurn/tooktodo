//
//  ProjectTaskRoleAssignment+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/23/16.
//
//

#import "ProjectTaskRoleAssignment+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoleAssignment (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoleAssignment *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *taskRoleAssignmnetID;
@property (nullable, nonatomic, copy) NSNumber *projectPermission;
@property (nullable, nonatomic, copy) NSNumber *isBlocked;
@property (nullable, nonatomic, retain) ProjectTaskAssignee *assignee;
@property (nullable, nonatomic, retain) ProjectTaskRoleType *projectRoleType;
@property (nullable, nonatomic, retain) ProjectTaskRoleAssignments *projectRoleAssignments;
@property (nullable, nonatomic, retain) ProjectInviteInfo *invite;

@end

NS_ASSUME_NONNULL_END
