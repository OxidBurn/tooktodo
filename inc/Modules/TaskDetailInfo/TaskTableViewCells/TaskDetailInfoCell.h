//
//  TaskDetailInfoCell.h
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "TaskRowContent.h"
#import "ProjectsEnumerations.h"

@protocol TaskDetailCellDelegate;
@protocol TaskDetailCellDataSouce;

@interface TaskDetailInfoCell : UITableViewCell

//properties
@property (nonatomic, weak) id<TaskDetailCellDelegate> delegate;

// methods
- (void) fillCellWithContent: (TaskRowContent*) content;

@end

@protocol TaskDetailCellDelegate <NSObject>

- (void) performSegueWithID: (NSString*) segueID;

@end

