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

//#ifdef DEBUG
static NSString* serverURL         = @"http://api.taketowork.com:80/";
static NSString* loginURL          = @"http://api.taketowork.com:80/token";
static NSString* userInfoURL       = @"http://api.taketowork.com:80/api/Account/info";
static NSString* restorePassURL    = @"http://api.taketowork.com:80/api/Account/sendResetPasswordEmail";
static NSString* updatePasswordURL = @"http://api.taketowork.com:80/api/Account/ChangePassword";
static NSString* logoutURL         = @"http://api.taketowork.com:80/api/Account/Logout";
static NSString* updateUserInfoURL = @"http://api.taketowork.com:80/api/v2/account/info/common";
//
//#else
//static NSString* serverURL       = @"https://api.tooktodo.ru/";
//static NSString* loginURL        = @"https://api.tooktodo.ru/token";
//static NSString* restorePassURL  = @"https://api.tooktodo.ru/api/Account/sendResetPasswordEmail";
//
//#endif

#endif /* APIConstance_h */
