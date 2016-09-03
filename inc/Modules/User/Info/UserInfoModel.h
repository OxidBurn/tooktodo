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

- (void) updateInfo;

- (NSString*) getFullUserName;

- (UIImage*) getUserAvatarImage;

- (NSArray*) getUserContactInfo;

- (RACSignal*) logoutUser;

- (void) saveNewAvatar: (UIImage*) image;

- (NSURL*) getUserAvatarURL;

@end
