//
//  LogWithChangedStatusCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "LogsContent.h"

@interface LogWithChangedStatusCell : UITableViewCell

// methods
- (void) fillLogCellWithContent: (LogsContent*) logContent;

@end
