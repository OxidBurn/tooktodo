//
//  ProjectTaskOwner+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectTaskOwner.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskOwner (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *additionalPhoneNumber;
@property (nullable, nonatomic, retain) NSString *avatarSrc;
@property (nullable, nonatomic, retain) NSString *displayName;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSNumber *emailConfirmed;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSNumber *ownerID;
@property (nullable, nonatomic, retain) NSNumber *isSubscribedOnEmailNotifications;
@property (nullable, nonatomic, retain) NSNumber *isTourViewed;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSString *userName;
@property (nullable, nonatomic, retain) ProjectRoles *role;
@property (nullable, nonatomic, retain) ProjectTask *task;

@end

NS_ASSUME_NONNULL_END
