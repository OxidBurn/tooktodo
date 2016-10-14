//
//  DataManager+UserInfo.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"
#import "UserInfo.h"
#import "UserInfoData.h"
#import "UpdatedUserInfo.h"
#import "UserNotifications.h"

@interface DataManager (UserInfo)

- (void) persistUserWithInfo: (UserInfoData*)           info
              withCompletion: (void(^)(BOOL isSuccess)) completion;

- (UserInfo*) getCurrentUserInfo;

- (NSNumber*) getCurrentUserID;

- (void) updateUserInfo: (UpdatedUserInfo*)        newInfo
                forUser: (UserInfo*)               user
         withCompletion: (void(^)(BOOL isSuccess)) completion;

- (void) deleteCurrentUser: (UserInfo*) info;

- (NSArray*) getAllUserInfo;

@end
