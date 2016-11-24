//
//  ProjectTaskResponsible+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "ProjectTaskResponsible+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskResponsible (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskResponsible *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *avatarSrc;
@property (nullable, nonatomic, copy) NSString *displayName;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSNumber *isActiveUser;
@property (nullable, nonatomic, copy) NSNumber *isBlocked;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSNumber *projectPermission;
@property (nullable, nonatomic, copy) NSNumber *responsibleID;
@property (nullable, nonatomic, retain) ProjectTaskAssignee *assignee;
@property (nullable, nonatomic, retain) ProjectInviteInfo *invite;
@property (nullable, nonatomic, retain) ProjectTaskRoleType *projectRoleType;
@property (nullable, nonatomic, retain) ProjectTask *task;

@end

NS_ASSUME_NONNULL_END
