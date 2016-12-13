//
//  User.h
//  addUserTest
//
//  Created by Nikolay Chaban on 26.08.16.
//  Copyright © 2016 Valeriya.Mozgovaya. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface InviteInfo : JSONModel

//properties
@property (strong, nonatomic) NSNumber* projectId;
@property (nonatomic, strong) NSString* email;
@property (strong, nonatomic) NSNumber* userId;
@property (nonatomic, strong) NSString* message;
@property (nonatomic, strong) NSNumber* projectRoleTypeId;
@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (strong, nonatomic) NSNumber* contactId;

@end
