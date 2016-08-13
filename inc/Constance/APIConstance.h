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
static NSString* serverURL       = @"https://api.tooktodo.ru:443/";
static NSString* loginURL        = @"https://api.tooktodo.ru:443/token";
static NSString* restorePassURL  = @"https://api.tooktodo.ru:443/api/Account/sendResetPasswordEmail";
#else
static NSString* serverURL       = @"https://api.tooktodo.ru/";
static NSString* loginURL        = @"https://api.tooktodo.ru/token";
static NSString* restorePassURL  = @"https://api.tooktodo.ru/api/Account/sendResetPasswordEmail";

#endif

#endif /* APIConstance_h */
