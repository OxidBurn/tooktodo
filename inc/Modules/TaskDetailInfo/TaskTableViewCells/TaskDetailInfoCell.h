//
//  TaskDetailInfoCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "TaskRowContent.h"
#import "ProjectsEnumerations.h"

@protocol TaskDetailCellDelegate;

@interface TaskDetailInfoCell : UITableViewCell

//properties
@property (nonatomic, weak) id<TaskDetailCellDelegate> delegate;

// methods
- (void) fillCellWithContent: (TaskRowContent*) content;

@end

@protocol TaskDetailCellDelegate <NSObject>

- (void) performSegueWithID: (NSString*) segueID;

- (void) showPopover: (CGRect) senderFrame;

@end

