//
//  TeamMember+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/3/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "TeamMember.h"

NS_ASSUME_NONNULL_BEGIN

@interface TeamMember (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *additionalPhoneNumber;
@property (nullable, nonatomic, retain) NSString *comment;
@property (nullable, nonatomic, retain) NSString *company;
@property (nullable, nonatomic, retain) NSNumber *createrUserId;
@property (nullable, nonatomic, retain) NSString *email;
@property (nullable, nonatomic, retain) NSString *firstName;
@property (nullable, nonatomic, retain) NSString *lastName;
@property (nullable, nonatomic, retain) NSString *patronymicName;
@property (nullable, nonatomic, retain) NSString *phoneNumber;
@property (nullable, nonatomic, retain) NSNumber *userID;
@property (nullable, nonatomic, retain) NSString *avatarPath;
@property (nullable, nonatomic, retain) ProjectInfo *project;

@end

NS_ASSUME_NONNULL_END
