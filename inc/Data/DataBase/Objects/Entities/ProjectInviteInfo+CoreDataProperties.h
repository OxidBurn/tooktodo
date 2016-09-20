//
//  ProjectInviteInfo+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/20/16.
//
//

#import "ProjectInviteInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectInviteInfo (CoreDataProperties)

+ (NSFetchRequest<ProjectInviteInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSNumber *inviteID;
@property (nullable, nonatomic, copy) NSNumber *inviteStatus;
@property (nullable, nonatomic, copy) NSNumber *isCanceled;
@property (nullable, nonatomic, copy) NSNumber *isUsed;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *message;
@property (nullable, nonatomic, copy) NSNumber *projectId;
@property (nullable, nonatomic, copy) NSString *projectName;
@property (nullable, nonatomic, retain) ProjectRoleAssignments *projectRoleAssignment;
@property (nullable, nonatomic, retain) ProjectRoleType *projectRoleType;
@property (nullable, nonatomic, retain) ProjectTaskResponsible *projectTaskResponsible;

@end

NS_ASSUME_NONNULL_END
