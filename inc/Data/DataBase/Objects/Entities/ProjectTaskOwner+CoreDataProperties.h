//
//  ProjectTaskOwner+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "ProjectTaskOwner+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskOwner (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskOwner *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *additionalPhoneNumber;
@property (nullable, nonatomic, copy) NSString *avatarSrc;
@property (nullable, nonatomic, copy) NSString *displayName;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSNumber *emailConfirmed;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSNumber *isSubscribedOnEmailNotifications;
@property (nullable, nonatomic, copy) NSNumber *isTourViewed;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSNumber *ownerID;
@property (nullable, nonatomic, copy) NSString *phoneNumber;
@property (nullable, nonatomic, copy) NSString *userName;
@property (nullable, nonatomic, retain) ProjectRoles *role;
@property (nullable, nonatomic, retain) ProjectTask *task;

@end

NS_ASSUME_NONNULL_END
