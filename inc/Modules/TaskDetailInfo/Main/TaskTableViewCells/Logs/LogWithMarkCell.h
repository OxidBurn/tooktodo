//
//  LogWithMarkCell.h
//  TookTODO
//
//  Created by Nikolay Chaban on 24.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "LogsContent.h"

@interface LogWithMarkCell : UITableViewCell

// methods
- (void) fillLogCellWithContent: (LogsContent*) logContent;

@end
