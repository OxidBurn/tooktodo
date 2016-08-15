//
//  DataManager+UserInfo.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"
#import "UserInfo.h"

@interface DataManager (UserInfo)

- (void) persistUserWithInfo: (NSDictionary*) info;

- (UserInfo*) getCurrentUserInfo;

@end
