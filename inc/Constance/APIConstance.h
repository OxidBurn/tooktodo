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

#ifdef DEBUG
//static NSString* serverURL           = @"http://api.taketowork.com:80/";
static NSString* serverURL           = @"https://api.tooktodo.ru/";
#else
static NSString* serverURL           = @"https://api.tooktodo.ru/";
#endif

static NSString* loginURL            = @"token";
static NSString* userInfoURL         = @"api/Account/info";
static NSString* restorePassURL      = @"api/Account/sendResetPasswordEmail";
static NSString* updatePasswordURL   = @"api/Account/ChangePassword";
static NSString* logoutURL           = @"api/Account/Logout";
static NSString* updateUserInfoURL   = @"api/v2/account/info/common";
static NSString* userProjectsListURL = @"api/project/list";
static NSString* fileInfoURL         = @"api/file";
static NSString* updateAvatarURL     = @"/api/Account/avatar";
static NSString* projectTeamInfoURL  = @"api/v2/project/{projectID}/contacts";
static NSString* inviteURL           = @"api/invite/send";
static NSString* projectRolesURL     = @"api/project/{projectID}/roleType/list";
static NSString* projectSystemsURL   = @"api/project/{projectID}/workAreas";

#endif /* APIConstance_h */
