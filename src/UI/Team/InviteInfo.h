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
@property (nonatomic, strong) NSString* lastname;
@property (nonatomic, strong) NSString* name;
@property (nonatomic, strong) NSString* email;
@property (nonatomic, strong) NSString* role;
@property (nonatomic, strong) NSString* message;

@end
