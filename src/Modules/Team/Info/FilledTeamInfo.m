//
//  FilledTeamInfo.m
//  TookTODO
//
//  Created by Lera on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilledTeamInfo.h"
#import "Utils.h"

@interface FilledTeamInfo()



@end

@implementation FilledTeamInfo

- (void) fillTeamInfo: (ProjectRoleAssignments*) assignment
{
    if (assignment.assignee != nil)
    {
        ProjectTaskAssignee* assignee = assignment.assignee;
        ProjectRoles* role = assignee.role;
        
        self.firstName       = assignee.firstName ? assignee.firstName : @"";
        self.lastName        = assignee.lastName ? assignee.lastName : @"";
        self.fullname        = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
        self.email           = assignee.email ? assignee.email : @"";
        self.phoneNumber        = assignee.phoneNumber ? assignee.phoneNumber : @"";
        self.additionalPhoneNumber = assignee.additionalPhoneNumber ? assignee.additionalPhoneNumber : @"";
        self.role            = role.title ? role.title : @"";
        self.avatarSrc      = assignee.avatarSrc ? assignee.avatarSrc : @"";
       self.projectPermission = assignment.projectPermission ? assignment.projectPermission : @(-2);
        
    }
    
    else if (assignment.invite != nil)
    {
        
        ProjectInviteInfo* invite = assignment.invite;
        ProjectRoleType* role = invite.projectRoleType;
        
        self.firstName = invite.firstName ? invite.firstName : @"";
        self.lastName  = invite.lastName ? invite.firstName : @"";
        self.fullname  = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
        self.email     = invite.email ? invite.firstName : @"";
        self.phoneNumber  = @"";
        self.additionalPhoneNumber = @"";
        self.role = role.title ? role.title : @"";
        self.avatarSrc = @"";
        self.projectPermission = assignment.projectPermission ? assignment.projectPermission : @(-2);
    }
    
    else
    {
        self.firstName =  @"";
        self.lastName  =  @"";
        self.fullname  = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
        self.email     =  @"";
        self.phoneNumber  = @"";
        self.additionalPhoneNumber = @"";
        self.role = @"";
        self.avatarSrc = @"";
        self.projectPermission = assignment.projectPermission ? assignment.projectPermission : @(-2);
    }
}

@end
