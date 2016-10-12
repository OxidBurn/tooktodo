//
//  TaskModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaskDetailModel : NSObject

// methods
- (NSUInteger) returnNumberOfRowsForIndexPath: (NSInteger) section;

- (UITableViewCell*) createCellForTableView: (UITableView*) tableView
                               forIndexPath: (NSIndexPath*) indexPath;

- (CGFloat) returnHeigtForRowAtIndexPath: (NSIndexPath*) indexPath
                            forTableView: (UITableView*) tableView;

- (NSArray*) returnHeaderInfo;

- (UIView*) returnHeaderForSection;

- (CGFloat) returnHeaderHeight;

- (void) deselectTask;

- (void) updateSecondSectionContentType: (NSUInteger) typeIndex;

@end
