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
#import "ProjectTaskRoleAssignment+CoreDataClass.h"
#import "ProjectTaskRoleAssignments+CoreDataProperties.h"
#import "ProjectsEnumerations.h"
#import "DataManager+Tasks.h"
#import "ProjectInfo+CoreDataClass.h"
#import "DataManager+ProjectInfo.h"

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
        self.taskRoleAssinment      = assignee.roleAssignment.projectRoleAssignments.taskRoleType;
        
        //used for sending task role assignments (responsible, approver, observer) on server
        self.memberID               = assignment.roleID;
        self.isBlocked              = assignment.isBlocked.boolValue ? assignment.isBlocked.boolValue : NO;
        self.assignments            = assignment;
        
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
        
        //used for sending task role assignments (responsible, approver, observer) on server
        self.memberID               = assignment.roleID;
        self.taskRoleAssinment      = invite.projectTaskAssignment.projectRoleAssignments.taskRoleType;
        self.isBlocked              = assignment.isBlocked.boolValue ? assignment.isBlocked.boolValue : NO;
        self.assignments            = assignment;
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
}

- (void) convertTaskResponsibleToTeamInfo: (ProjectTaskResponsible*) taskResponsible
{
    self.userId                = taskResponsible.responsibleID ? taskResponsible.responsibleID : @(-1);
    self.firstName             = taskResponsible.firstName     ? taskResponsible.firstName   : @"";
    self.lastName              = taskResponsible.lastName      ? taskResponsible.lastName    : @"";
    self.fullname              = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
    self.avatarSrc             = taskResponsible.avatarSrc     ? taskResponsible.avatarSrc   : @"";
    self.projectPermission     = @(-2);
}

- (void) convertAssigneeToTeamInfo: (ProjectTaskAssignee*) assignee
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    NSArray* assignments = project.projectRoleAssignments.array;
    
    [assignments enumerateObjectsUsingBlock: ^(ProjectRoleAssignments*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.assignee != nil)
        {
            self.role = obj.projectRoleType.title;
            self.memberID = obj.roleID;
        }
        
    }];
    
    self.userId            = assignee.assigneeID ? assignee.assigneeID : @(-1);
    self.firstName         = assignee.firstName ? assignee.firstName : @"";
    self.lastName          = assignee.lastName ? assignee.lastName : @"";
    self.fullname          = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
    self.avatarSrc         = assignee.avatarSrc ? assignee.avatarSrc : @"";
    self.taskRoleAssinment = assignee.roleAssignment.projectRoleAssignments.taskRoleType;


}

- (void) convertInviteToTeamInfo: (ProjectInviteInfo*) invite
{
    ProjectInfo* project = [DataManagerShared getSelectedProjectInfo];
    
    NSArray* assignments = project.projectRoleAssignments.array;
    
    [assignments enumerateObjectsUsingBlock: ^(ProjectRoleAssignments*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.invite != nil)
        {
            self.role = obj.projectRoleType.title;
            self.memberID = obj.roleID;
        }
        
    }];
    
    self.userId            = invite.inviteID;
    self.firstName         = invite.firstName ? invite.firstName : @"";
    self.lastName          = invite.lastName ? invite.lastName : @"";
    self.fullname          = [NSString stringWithFormat: @"%@ %@", self.firstName, self.lastName];
    self.avatarSrc         = @"";
    self.taskRoleAssinment = invite.projectTaskAssignment.projectRoleAssignments.taskRoleType;
    
}
@end
