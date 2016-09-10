//
//  TaskAssigneeModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>
#import "ProjectRoleModel.h"

@interface TaskAssigneeModel : JSONModel

@property (strong, nonatomic) NSString<Optional> * additionalPhoneNumber;
@property (strong, nonatomic) NSString   * avatarSrc;
@property (strong, nonatomic) NSString   * displayName;
@property (strong, nonatomic) NSString   * email;
@property (assign, nonatomic) BOOL       emailConfirmed;
@property (strong, nonatomic) NSString   * firstName;
@property (assign, nonatomic) NSUInteger * assigneeID;
@property (assign, nonatomic) BOOL       isSubscribedOnEmailNotifications;
@property (assign, nonatomic) BOOL       isTourViewed;
@property (strong, nonatomic) NSString   * lastName;
@property (strong, nonatomic) NSString   * phoneNumber;
@property (strong, nonatomic) ProjectRoleModel<Optional  > * role;
@property (strong, nonatomic) NSString   * userName;



@end
