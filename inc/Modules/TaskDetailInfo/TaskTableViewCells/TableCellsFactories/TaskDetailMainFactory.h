//
//  TaskDetailMainFactory.h
//  TookTODO
//
//  Created by Глеб on 18.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "TaskRowContent.h"

@interface TaskDetailMainFactory : NSObject

// methods
- (UITableViewCell*) createCellForTableView: (UITableView*)    tableView
                                withContent: (TaskRowContent*) content;

@end
