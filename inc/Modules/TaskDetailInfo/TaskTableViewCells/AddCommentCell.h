//
//  AddCommentCell.h
//  TookTODO
//
//  Created by Chaban Nikolay on 12.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddCommentCell;

@protocol AddCommentCellDelegate <NSObject>

- (void)    addCommentCell: (AddCommentCell*)addCommentCell
   newCommentTextDidChange: (UITextView*)sender;
- (void)    addCommentCell: (AddCommentCell*)addCommentCell
               onSendClick: (UIButton*)sender;

@end

@interface AddCommentCell : UITableViewCell

// outlets
@property (nonatomic) IBOutlet UITextView *addCommentTextView;

@property (weak, nonatomic) id<AddCommentCellDelegate> delegate;

@end
