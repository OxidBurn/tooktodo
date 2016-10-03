//
//  FilledTeamInfo.m
//  TookTODO
//
//  Created by Lera on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilledTeamInfo.h"
#import "Utils.h"
#import "TeamProfileInfoModel.h"

@implementation FilledTeamInfo

- (void) fillTeamInfo: (ProjectRoleAssignments*) assignment
{
    if (assignment.assignee != nil)
    {
        ProjectTaskAssignee* assignee = assignment.assignee;
        ProjectRoleType* roleType     = assignment.projectRoleType;
        
        self.userId                 = assignee.assigneeID ? assignee.assigneeID : @(-1);
        self.firstName              = assignee.firstName ? assignee.firstName : @"";
        self.lastName               = assignee.lastName ? assignee.lastName : @"";
        self.fullname               = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
        self.email                  = assignee.email ? assignee.email : @"";
        self.phoneNumber            = assignee.phoneNumber ? assignee.phoneNumber : @"";
        self.additionalPhoneNumber  = assignee.additionalPhoneNumber ? assignee.additionalPhoneNumber : @"";
        self.role                   = roleType.title ? roleType.title : @"";
        self.avatarSrc              = assignee.avatarSrc ? assignee.avatarSrc : @"";
        self.projectPermission      = assignment.projectPermission ? assignment.projectPermission : @(-2);
        self.isResponsible          = self.isResponsible ? self.isResponsible : NO;
        self.isClaiming             = self.isClaiming ? self.isClaiming : NO;
        self.isObserver             = self.isObserver ? self.isObserver : NO;
        
    }
    
    else if (assignment.invite != nil)
    {
        
        ProjectInviteInfo* invite = assignment.invite;
        ProjectRoleType* roleType = assignment.projectRoleType;

        self.userId                 = invite.inviteID ? invite.inviteID : @(-1);
        self.firstName              = invite.firstName ? invite.firstName : @"";
        self.lastName               = invite.lastName ? invite.firstName : @"";
        self.fullname               = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
        self.email                  = invite.email ? invite.firstName : @"";
        self.phoneNumber            = @"";
        self.additionalPhoneNumber  = @"";
        self.role                   = roleType.title ? roleType.title : @"";
        self.avatarSrc              = @"";
        self.projectPermission      = assignment.projectPermission ? assignment.projectPermission : @(-2);
        self.isResponsible          = self.isResponsible ? self.isResponsible : NO;
        self.isClaiming             = self.isClaiming ? self.isClaiming : NO;
        self.isObserver             = self.isObserver ? self.isObserver : NO;
    }
    
    else
    {
#warning <#message#>
        self.userId                 = @(-1);
        self.firstName              = @"";
        self.lastName               = @"";
        self.fullname               = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
        self.email                  = @"";
        self.phoneNumber            = @"";
        self.additionalPhoneNumber  = @"";
        self.role                   = @"";
        self.avatarSrc              = @"";
        self.projectPermission      = assignment.projectPermission ? assignment.projectPermission : @(-2);
        self.isResponsible          = self.isResponsible ? self.isResponsible : NO;
        self.isClaiming             = self.isClaiming ? self.isClaiming : NO;
        self.isObserver             = self.isObserver ? self.isObserver : NO;
    }
}

- (void) convertUserToTeamInfo: (UserInfo*) user
{
    self.userId                = user.userID ? user.userID : @(-1);
    self.firstName             = user.firstName     ? user.firstName   : @"";
    self.lastName              = user.lastName      ? user.lastName    : @"";
    self.fullname              = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
    self.email                 = user.email         ? user.email       : @"";
    self.phoneNumber           = user.phoneNumber   ? user.phoneNumber : @"";
    self.additionalPhoneNumber = @"";
    self.role                  = @"";
    self.avatarSrc             = user.avatarSrc     ? user.avatarSrc   : @"";
    self.projectPermission     = @(-2);
    self.isResponsible         = self.isResponsible ? self.isResponsible : NO;
    self.isClaiming             = self.isClaiming ? self.isClaiming : NO;
    self.isObserver             = self.isObserver ? self.isObserver : NO;
}

@end
