//
//  User.m
//  addUserTest
//
//  Created by Nikolay Chaban on 26.08.16.
//  Copyright © 2016 Valeriya.Mozgovaya. All rights reserved.
//

#import "InviteInfo.h"
#import "DataManager+Roles.h"
#import "ProjectRoles.h"

@interface InviteInfo()

// properties


// methods

- (void) setupDefaults;

@end

@implementation InviteInfo


#pragma mark - Initialization -

- (instancetype)init
{
    if ( self = [super init] )
    {
        [self setupDefaults];
    }
    
    return self;
}


#pragma mark - Internal methods -

- (void) setupDefaults
{
    ProjectRoles* role = [[DataManagerShared getAllRolesInCurrentProject] firstObject];
    
    self.projectRoleTypeId = role.roleID;
}

@end
