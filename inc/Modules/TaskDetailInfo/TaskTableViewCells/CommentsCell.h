//
//  CommentsCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "TaskRowContent.h"

@protocol CommentCellDelegate;

@interface CommentsCell : UITableViewCell

// properties
@property (weak, nonatomic) id <CommentCellDelegate> delegate;

// methods
- (void) fillCellWithContent: (TaskRowContent*) content
                   withWidth: (CGFloat)         width
                withDelegate: (id)              delegate;

@end

@protocol CommentCellDelegate <NSObject>

- (void) updateTableView;

@end
