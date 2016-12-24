//
//  LogWithMarkCellFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 24.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "TaskRowContent.h"

@interface LogWithMarkCellFactory : NSObject

// methods
- (UITableViewCell*) returnLogCellForTableView: (UITableView*)    tableView
                                   withContent: (TaskRowContent*) content;

@end
