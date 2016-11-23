//
//  LogCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogCell : UITableViewCell

// methods
- (void) fillLogCellWithText: (NSString*) text
                    withDate: (NSString*) date
              withUserAvatar: (NSString*) avatarSrc;

@end
