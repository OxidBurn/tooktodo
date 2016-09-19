//
//  ProjectTaskAssignee+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/19/16.
//
//

#import "ProjectTaskAssignee+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskAssignee (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskAssignee *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *additionalPhoneNumber;
@property (nullable, nonatomic, copy) NSNumber *assigneeID;
@property (nullable, nonatomic, copy) NSString *avatarSrc;
@property (nullable, nonatomic, copy) NSString *displayName;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSNumber *emailConfirmed;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSNumber *isSubscribedOnEmailNotifications;
@property (nullable, nonatomic, copy) NSNumber *isTourViewed;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *phoneNumber;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, retain) ProjectTaskResponsible *responsible;
@property (nullable, nonatomic, retain) ProjectRoles *role;
@property (nullable, nonatomic, retain) ProjectTaskRoleAssignment *roleAssignment;
@property (nullable, nonatomic, retain) ProjectRoleAssignments *projectRoleAssignment;

@end

NS_ASSUME_NONNULL_END
