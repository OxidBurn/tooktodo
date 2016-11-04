//
//  FilterByDatesFactory.h
//  TookTODO
//
//  Created by Nikolay Chaban on 04.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

// Classes
#import "RowContent.h"


@interface FilterByDatesFactory : NSObject

// methods

- (UITableViewCell*) returnCellForTableView: (UITableView*) tableView
                              withIndexPath: (NSIndexPath*) indexPath
                                withContent: (RowContent*)  rowContent
                               withDelegate: (id)           delegate;

@end
