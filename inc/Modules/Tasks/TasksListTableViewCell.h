//
//  TasksListTableViewCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 8/26/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AllTaskBaseTableViewCell.h"

@protocol TaskListTableViewCellDelegate;

@interface TasksListTableViewCell : AllTaskBaseTableViewCell

// properties
@property (nonatomic, weak) id <TaskListTableViewCellDelegate> delegate;

// methods

@end

@protocol TaskListTableViewCellDelegate <NSObject>

- (void) performSegueToChangeStatusWithID: (NSString*) segueID;

@end
