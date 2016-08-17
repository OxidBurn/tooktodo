//
//  UserInfoViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface UserInfoViewModel : NSObject <UITableViewDataSource>

// methods

- (UIImage*) userAvatar;

- (NSString*) fullUserName;

- (CGFloat) contactTableHeight;

@end
