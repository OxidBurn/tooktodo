//
//  UserInfoModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

@interface UserInfoModel : NSObject

// properties


// methods

- (RACSignal*) updateInfo;

- (NSString*) getFullUserName;

- (UIImage*) getUserAvatarImage;

- (NSArray*) getUserContactInfo;

- (void) updateCurrentUserInfoWithCompletion: (CompletionWithSuccess) completion;

- (RACSignal*) logoutUser;

- (void) saveNewAvatar: (UIImage*)                image
        withCompletion: (void(^)(UIImage* image)) completion;

- (NSURL*) getUserAvatarURL;

@end
