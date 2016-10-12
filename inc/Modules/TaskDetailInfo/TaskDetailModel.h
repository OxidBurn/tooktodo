//
//  TaskModel.h
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TaskDetailModelDelegate;

@interface TaskDetailModel : NSObject

//Properties

@property (nonatomic, weak) id<TaskDetailModelDelegate> delegate;

// methods
- (NSUInteger) returnNumberOfRowsForIndexPath: (NSInteger) section;

- (UITableViewCell*) createCellForTableView: (UITableView*) tableView
                               forIndexPath: (NSIndexPath*) indexPath;

- (CGFloat) returnHeigtForRowAtIndexPath: (NSIndexPath*) indexPath
                            forTableView: (UITableView*) tableView;

- (NSArray*) returnFooterInfo;

- (UIView*) returnHeaderForSection;

- (CGFloat) returnHeaderHeight;

- (void) deselectTask;

- (void) updateSecondSectionContentType: (NSUInteger) typeIndex;

@end

@protocol TaskDetailModelDelegate <NSObject>

- (void) reloadData;

@end
