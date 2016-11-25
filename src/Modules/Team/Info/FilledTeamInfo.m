//
//  FilledTeamInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilledTeamInfo.h"

// Classes
#import "Utils.h"
#import "TeamProfileInfoModel.h"
#import "ProjectInfo+CoreDataClass.h"
#import "ProjectTaskResponsible+CoreDataProperties.h"

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
        self.memberID               = assignee.assigneeID;
        self.hasApprovedTask        = self.hasApprovedTask ? self.hasApprovedTask : NO;
    }
    else if (assignment.invite != nil)
    {
        
        ProjectInviteInfo* invite = assignment.invite;
        ProjectRoleType* roleType = assignment.projectRoleType;

        self.userId                 = invite.inviteID;
        self.firstName              = invite.firstName ? invite.firstName : @"";
        self.lastName               = invite.lastName ? invite.lastName : @"";
        self.fullname               = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
        self.email                  = invite.email ? invite.email : @"";
        self.phoneNumber            = @"";
        self.additionalPhoneNumber  = @"";
        self.role                   = roleType.title ? roleType.title : @"";
        self.avatarSrc              = @"";
        self.projectPermission      = assignment.projectPermission ? assignment.projectPermission : @(-2);
        self.isResponsible          = self.isResponsible ? self.isResponsible : NO;
        self.isClaiming             = self.isClaiming ? self.isClaiming : NO;
        self.isObserver             = self.isObserver ? self.isObserver : NO;
        self.memberID               = invite.inviteID;
        self.hasApprovedTask        = self.hasApprovedTask ? self.hasApprovedTask : NO;
    }
    
    self.roleID    = assignment.roleID;
    self.projectID = assignment.project.projectID;
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

- (void) convertTaskOwnerToTeamInfo: (ProjectTaskOwner*) projectOwner
{
    self.userId                = projectOwner.ownerID ? projectOwner.ownerID : @(-1);
    self.firstName             = projectOwner.firstName     ? projectOwner.firstName   : @"";
    self.lastName              = projectOwner.lastName      ? projectOwner.lastName    : @"";
    self.fullname              = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
    self.email                 = projectOwner.email         ? projectOwner.email       : @"";
    self.phoneNumber           = projectOwner.phoneNumber   ? projectOwner.phoneNumber : @"";
    self.additionalPhoneNumber = @"";
    self.role                  = @"";
    self.avatarSrc             = projectOwner.avatarSrc     ? projectOwner.avatarSrc   : @"";
    self.projectPermission     = @(-2);
    self.isResponsible         = self.isResponsible ? self.isResponsible : NO;
    self.isClaiming             = self.isClaiming ? self.isClaiming : NO;
    self.isObserver             = self.isObserver ? self.isObserver : NO;
}

- (void) convertTaskResponsibleToTeamInfo: (ProjectTaskResponsible*) taskResponsible
{
    self.userId                = taskResponsible.responsibleID ? taskResponsible.responsibleID : @(-1);
    self.firstName             = taskResponsible.firstName     ? taskResponsible.firstName   : @"";
    self.lastName              = taskResponsible.lastName      ? taskResponsible.lastName    : @"";
    self.fullname              = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
    self.avatarSrc             = taskResponsible.avatarSrc     ? taskResponsible.avatarSrc   : @"";
    self.projectPermission     = @(-2);
    self.isResponsible         = self.isResponsible ? self.isResponsible : NO;
    self.isClaiming            = self.isClaiming ? self.isClaiming : NO;
    self.isObserver            = self.isObserver ? self.isObserver : NO;
}

- (void) convertAssigneeToFilledInfo: (ProjectTaskAssignee*) assignee
{

}

- (void) convertInviteInfo: (ProjectInviteInfo*) invite
              toFilledUser: (FilledTeamInfo*)    user
{
    
}

@end
