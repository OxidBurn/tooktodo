//
//  ProjectRoleAssignments+CoreDataProperties.h
//  
//
//  Created by Lera on 19.09.16.
//
//

#import "ProjectRoleAssignments+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectRoleAssignments (CoreDataProperties)

+ (NSFetchRequest<ProjectRoleAssignments *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *isBlocked;
@property (nullable, nonatomic, copy) NSNumber *projectPermission;
@property (nullable, nonatomic, copy) NSNumber *roleID;
@property (nullable, nonatomic, copy) NSNumber *isSelected;
@property (nullable, nonatomic, retain) ProjectTaskAssignee *assignee;
@property (nullable, nonatomic, retain) ProjectInviteInfo *invite;
@property (nullable, nonatomic, retain) ProjectInfo *project;
@property (nullable, nonatomic, retain) ProjectRoleType *projectRoleType;

@end

NS_ASSUME_NONNULL_END
