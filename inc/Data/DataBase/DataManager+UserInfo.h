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

@interface DataManager (UserInfo)

- (void) persistUserWithInfo: (UserInfoData*)           info
              withCompletion: (void(^)(BOOL isSuccess)) completion;

- (UserInfo*) getCurrentUserInfo;

- (void) updateUserInfo: (UserInfo*) info;

- (void) deleteCurrentUser: (UserInfo*) info;

@end
