//
//  LogWithAssigneeCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 22.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "LogsContent.h"

@interface LogWithAssigneeCell : UITableViewCell

// methods
- (void) fillLogCellWithContent: (LogsContent*) logContent;

@end
