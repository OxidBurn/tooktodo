//
//  UserAPIService.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/29/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "BaseAPIService.h"

@interface UserAPIService : BaseAPIService

/**
 * gets singleton object.
 * @return singleton
 */
+ (UserAPIService*) sharedInstance;

- (RACSignal*) logOut;

- (RACSignal*) updateUserInfoOnServer: (NSDictionary*) parameters;

- (RACSignal*) updatePasswordFromOld: (NSString*) old
                               toNew: (NSString*) pass;

- (RACSignal*) getUserInfo;

- (void) getAvatarFileID: (NSString*)                                       filePath
          withCompletion: (void(^)(NSDictionary* response, NSError* error)) completion;

- (RACSignal*) updateAvatar: (NSDictionary*) parameters;

@end
