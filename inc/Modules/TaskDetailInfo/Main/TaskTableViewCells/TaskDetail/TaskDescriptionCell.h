//
//  TaskDescriptionCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "TaskRowContent.h"

@interface TaskDescriptionCell : UITableViewCell

// methods
- (void) fillCellWithContent: (TaskRowContent*) content;

@end
