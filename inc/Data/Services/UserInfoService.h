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
#import "DataManager+ProjectInfo.h"

// Classes
#import "UpdatedUserInfo.h"

@interface UserInfoService : NSObject

/**
 * gets singleton object.
 * @return singleton
 */
+ (UserInfoService*) sharedInstance;

- (RACSignal*) logoutUser: (UserInfo*) info;

- (void) updateInfoForUser: (UserInfo*)               user
               withNewInfo: (UpdatedUserInfo*)        newInfo
            withCompletion: (void(^)(BOOL isSuccess)) completion;

- (void) updateAvatarWithFile: (NSString*)             filePath
               withCompletion: (CompletionWithSuccess) completion;

- (RACSignal*) getNewUserInfo;

- (NSNumber*) getUserID;

@end
