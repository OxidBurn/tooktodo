//
//  TeamMember+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "TeamMember+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TeamMember (CoreDataProperties)

+ (NSFetchRequest<TeamMember *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *additionalPhoneNumber;
@property (nullable, nonatomic, copy) NSString *avatarSrc;
@property (nullable, nonatomic, copy) NSString *comment;
@property (nullable, nonatomic, copy) NSString *company;
@property (nullable, nonatomic, copy) NSNumber *createrUserId;
@property (nullable, nonatomic, copy) NSString *email;
@property (nullable, nonatomic, copy) NSString *firstName;
@property (nullable, nonatomic, copy) NSNumber *isSelected;
@property (nullable, nonatomic, copy) NSString *lastName;
@property (nullable, nonatomic, copy) NSString *patronymicName;
@property (nullable, nonatomic, copy) NSString *phoneNumber;
@property (nullable, nonatomic, copy) NSNumber *userID;
@property (nullable, nonatomic, retain) ProjectInfo *project;

@end

NS_ASSUME_NONNULL_END
