//
//  AddTaskTermsModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 19.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AddTaskTermsModel : NSObject

// methods
- (NSUInteger) getNumberOfRows;

- (UITableViewCell*) returnCellForTableView: (UITableView*) tableView
                              withIndexPath: (NSIndexPath*) indexPath;
@end
