//
//  TaskAssigneeModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ProjectRoleModel.h"

@protocol TaskAssigneeModel;

@interface TaskAssigneeModel : JSONModel

@property (strong, nonatomic) NSString<Optional> * additionalPhoneNumber;
@property (strong, nonatomic) NSString<Optional>   * avatarSrc;
@property (strong, nonatomic) NSString<Optional>   * displayName;
@property (strong, nonatomic) NSString<Optional>   * email;
@property (strong, nonatomic) NSNumber<Optional>* emailConfirmed;
@property (strong, nonatomic) NSString<Optional>   * firstName;
@property (assign, nonatomic) NSUInteger assigneeID;
@property (strong, nonatomic) NSNumber<Optional>* isSubscribedOnEmailNotifications;
@property (strong, nonatomic) NSNumber<Optional>* isTourViewed;
@property (strong, nonatomic) NSString<Optional>* lastName;
@property (strong, nonatomic) NSString<Optional>* phoneNumber;
@property (strong, nonatomic) ProjectRoleModel<Optional> * role;
@property (strong, nonatomic) NSString<Optional>   * userName;

@end
