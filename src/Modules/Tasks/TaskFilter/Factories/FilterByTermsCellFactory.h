//
//  FilterByTermsCellFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "FilterByTermsCell.h"
#import "TaskFilterRowContent.h"

@interface FilterByTermsCellFactory : NSObject

// methods

- (UITableViewCell*) returnFilterByTermsCellWithContent: (TaskFilterRowContent*) rowContent
                                           forTableView: (UITableView*)          tableView
                                           withDelegate: (id)                    delegate;
@end
