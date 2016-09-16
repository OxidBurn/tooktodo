//
//  AddTaskModel.h
//  TookTODO
//
//  Created by Глеб on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddTaskModel : NSObject

// methods

- (NSUInteger) getNumberOfRowsForSection: (NSUInteger) section;

- (UITableViewCell*) createCellForTableView: (UITableView*) tableView
                               forIndexPath: (NSIndexPath*) indexPath;

- (NSString*) getSegueIdForIndexPath: (NSIndexPath*) indexPath;

@end
