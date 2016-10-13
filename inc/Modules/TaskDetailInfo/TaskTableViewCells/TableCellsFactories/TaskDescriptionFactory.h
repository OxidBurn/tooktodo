//
//  TaskDescriptionFactory.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "TaskRowContent.h"

@interface TaskDescriptionFactory : NSObject

// methods
- (UITableViewCell*) returnDescriptionCellWithContent: (TaskRowContent*) content
                                         forTableView: (UITableView*)    tableView;

@end
