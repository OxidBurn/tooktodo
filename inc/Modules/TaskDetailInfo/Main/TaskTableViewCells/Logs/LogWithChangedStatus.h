//
//  LogWithChangedStatus.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogWithChangedStatus : UITableViewCell

// methods
- (void) fillLogCellWithText: (NSAttributedString*)  text
                    withDate: (NSString*)  date
              withUserAvatar: (NSString*)  avatarSrc
               withOldStatus: (NSUInteger) oldStatus
               withNewStatus: (NSUInteger) newStatus;
@end
