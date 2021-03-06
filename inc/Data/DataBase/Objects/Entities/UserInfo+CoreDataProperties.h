//
//  UserInfo+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 8/19/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserInfo (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSDate *expireTokenDate;
@property (nullable, nonatomic, retain) NSString *extendPhoneNumber;
@property (nullable, nonatomic, retain) NSString *fullName;
@property (nullable, nonatomic, retain) NSString *notificationSettingsPath;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSString *photoImagePath;
@property (nullable, nonatomic, retain) NSNumber *userID;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSNumber *isSubscribedOnEmailNotifications;
@property (nullable, nonatomic, retain) NSString *avatarSrc;

@end

NS_ASSUME_NONNULL_END
