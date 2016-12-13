//
//  ProjectInviteInfo.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/19/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <JSONModel/JSONModel.h>

// Classes
#import "ProjectRoleTypeModel.h"

@interface ProjectInviteInfoModel : JSONModel

@property (strong, nonatomic) NSString* email;
@property (strong, nonatomic) NSString<Optional>* firstName;
@property (strong, nonatomic) NSString<Optional>* lastName;
@property (strong, nonatomic) NSNumber* inviteID;
@property (strong, nonatomic) NSNumber* inviteStatus;
@property (strong, nonatomic) NSNumber* isCanceled;
@property (strong, nonatomic) NSNumber* isUsed;
@property (strong, nonatomic) NSString* message;
@property (strong, nonatomic) NSNumber* projectId;
@property (strong, nonatomic) NSString<Optional>* projectName;
@property (strong, nonatomic) ProjectRoleTypeModel<Optional>* projectRoleType;

@end
