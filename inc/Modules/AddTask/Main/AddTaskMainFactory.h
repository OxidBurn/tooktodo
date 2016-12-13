//
//  AddTaskMainFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 14.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "RowContent.h"

@interface AddTaskMainFactory : NSObject


// methods
- (UITableViewCell*) createCellForTableView: (UITableView*) tableView
                                withContent: (RowContent*)  content
                               withDelegate: (id)           delegate;

@end
