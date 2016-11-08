//
//  FilterSubtasksCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 12.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "TaskRowContent.h"

@protocol FilterSubtasksCellDelegate;

@interface FilterSubtasksCell : UITableViewCell

// properties

@property (nonatomic, weak) id <FilterSubtasksCellDelegate> delegate;

// methods
- (void) fillCellWithContent: (TaskRowContent*) content;

@end

@protocol FilterSubtasksCellDelegate <NSObject>

- (void) performSegueToAddSubtaskWithID: (NSString*) segueID;

@end
