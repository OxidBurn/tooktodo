//
//  UserNotificationCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 16.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserNotificationCell : UITableViewCell

- (void) fillCellWithText: (NSString*) cellText
            withSwitchTag: (NSNumber*) switchTag;

@end
