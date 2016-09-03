//
//  TeamMemberObject.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/3/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TeamMemberObject : JSONModel

@property (strong, nonatomic) NSString* firstName;
@property (strong, nonatomic) NSString* lastName;
@property (strong, nonatomic) NSString<Optional>* email;
@property (strong, nonatomic) NSString* patronymicName;
@property (strong, nonatomic) NSString<Optional>* company;
@property (strong, nonatomic) NSString<Optional>* phoneNumber;
@property (strong, nonatomic) NSString<Optional>* additionalPhoneNumber;
@property (strong, nonatomic) NSString<Optional>* comment;
@property (strong, nonatomic) NSNumber* memberID;
@property (strong, nonatomic) NSNumber* createrUserId;

@end
