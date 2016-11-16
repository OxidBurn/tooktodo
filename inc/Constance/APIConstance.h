//
//  APIConstance.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#ifndef APIConstance_h
#define APIConstance_h

@import Foundation;

// URLS
static NSString* registerPageURL = @"https://tooktodo.ru/login";

static NSString* serverURL = @"http://api.taketowork.com:80/";

static NSString* loginURL                       = @"token";
static NSString* userInfoURL                    = @"api/Account/info";
static NSString* restorePassURL                 = @"api/Account/sendResetPasswordEmail";
static NSString* updatePasswordURL              = @"api/Account/ChangePassword";
static NSString* logoutURL                      = @"api/Account/Logout";
static NSString* updateUserInfoURL              = @"api/v2/account/info/common";
static NSString* userProjectsListURL            = @"api/project/list";
static NSString* fileInfoURL                    = @"api/file";
static NSString* updateAvatarURL                = @"api/Account/avatar";
static NSString* projectTeamInfoURL             = @"api/v2/project/{projectID}/contacts";
static NSString* inviteURL                      = @"api/invite/send";
static NSString* projectRolesURL                = @"api/project/{projectID}/roleType/list";
static NSString* projectSystemsURL              = @"api/project/{projectID}/workAreas";
static NSString* projectUserPermissionURL       = @"api/project/{projectId}/participant/currentUserPermission";
static NSString* defaultRolesURL                = @"api/project/roleType/defaultList";
static NSString* projectTasksURL                = @"/api/project/{id}/tasks";
static NSString* allUserTasksURL                = @"api/v2/tasks/groupsByProject";
static NSString* projectRoleAssignmentsURL      = @"/api/project/{id}/projectRoleAssignments";
static NSString* projectRolePermissionURL       = @"/api/project/{projectId}/participant/{userId}/permission/admin";
static NSString* projectGetRoomsLevelURL        = @"/api/roomLevel/list?projectId=";
static NSString* projectTaskAvailableActionsURL = @"/api/v2/project/{projectId}/tasks/{taskId}/availableActions";
static NSString* createNewProjectRoleTypeURL    = @"/api/v2/project/{projectId}/roleTypes";
static NSString* createNewTaskURL               = @"/api/task";
static NSString* taskCommentsURL                = @"/api/task/p{projectId}-t{taskId}/comment/list";

#endif /* APIConstance_h */
