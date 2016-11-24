//
//  LogsCellFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 23.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "TaskRowContent.h"

@interface LogsCellFactory : NSObject

// methods
- (UITableViewCell*) returnLogCellForTableView: (UITableView*)    tableView
                                   withContent: (TaskRowContent*) content;

@end
