//
//  LogWithDetailCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogWithDetailCell : UITableViewCell

// methods
- (void) fillLogCellWithText: (NSAttributedString*) text
                    withDate: (NSString*) date
              withUserAvatar: (NSString*) avatarSrc
                withOldTerms: (NSString*) oldTerms
                withNewTerms: (NSString*) newTerms;
@end
