//
//  UserNotifications+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/1/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "UserNotifications.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserNotifications (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *allProject;
@property (nullable, nonatomic, retain) NSNumber *documents;
@property (nullable, nonatomic, retain) NSNumber *mine;
@property (nullable, nonatomic, retain) NSNumber *newsMessages;
@property (nullable, nonatomic, retain) NSNumber *projectProfile;
@property (nullable, nonatomic, retain) NSNumber *responder;
@property (nullable, nonatomic, retain) NSNumber *systems;
@property (nullable, nonatomic, retain) NSNumber *tasks;
@property (nullable, nonatomic, retain) NSNumber *team;
@property (nullable, nonatomic, retain) UserInfo *userInfo;

@end

NS_ASSUME_NONNULL_END
