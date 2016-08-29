//
//  UserInfoService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

// Extensions
#import "DataManager+UserInfo.h"

// Classes
#import "UpdatedUserInfo.h"

@interface UserInfoService : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (UserInfoService*) sharedInstance;

- (RACSignal*) logoutUser: (UserInfo*) info;

- (void) updateInfoForUser: (UserInfo*)        user
               withNewInfo: (UpdatedUserInfo*) newInfo;

@end
