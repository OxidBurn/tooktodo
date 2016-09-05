//
//  UserInfoViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;
#import "ReactiveCocoa.h"

@interface UserInfoViewModel : NSObject <UITableViewDataSource>

// properties
@property (strong, nonatomic) RACCommand* logoutCommand;

// methods

- (RACSignal*) updateInfo;

- (UIImage*) userAvatar;

- (NSString*) fullUserName;

- (CGFloat) contactTableHeight;

- (void) saveNewImage: (UIImage*) image;

- (NSURL*) getUserAvatarURL;

@end
