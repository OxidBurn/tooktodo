//
//  ProjectTaskAssignee+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectTaskAssignee.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskAssignee (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *additionalPhoneNumber;
@property (nullable, nonatomic, retain) NSString *avatarSrc;
@property (nullable, nonatomic, retain) NSString *displayName;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSNumber *emailConfirmed;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSNumber *assigneeID;
@property (nullable, nonatomic, retain) NSNumber *isSubscribedOnEmailNotifications;
@property (nullable, nonatomic, retain) NSNumber *isTourViewed;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) ProjectTaskResponsible *responsible;
@property (nullable, nonatomic, retain) ProjectTaskRoleAssignment *roleAssignment;
@property (nullable, nonatomic, retain) ProjectRoles *role;

@end

NS_ASSUME_NONNULL_END
