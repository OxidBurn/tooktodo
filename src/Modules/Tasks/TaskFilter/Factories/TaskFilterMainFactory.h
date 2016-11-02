//
//  TaskFilterMainFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "TaskFilterRowContent.h"

@interface TaskFilterMainFactory : NSObject

// methods
- (UITableViewCell*) createCellForTableView: (UITableView*)           tableView
                             withRowContent: (TaskFilterRowContent*)  content;

@end
