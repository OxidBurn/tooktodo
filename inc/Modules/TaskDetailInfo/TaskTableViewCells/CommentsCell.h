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
@property (weak, nonatomic) IBOutlet UITextView*     commentContentTextView;
@property (strong, nonatomic) NSNumber* commentID;

// methods
- (void) fillCellWithContent: (TaskRowContent*)      content
                   withWidth: (CGFloat)              width
                withDelegate: (id)                   delegate;

- (void) handleEditButtons: (BOOL) enabled;

@end

@protocol CommentCellDelegate <NSObject>

- (void) updateTableView;

- (void) commentsCell: (CommentsCell*) commentsCell
            onEditBtn: (id)            sender;
- (void) commentsCell: (CommentsCell*) commentsCell
          onCancelBtn: (id) sender;

@end
