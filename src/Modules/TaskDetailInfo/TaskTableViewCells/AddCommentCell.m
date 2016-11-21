//
//  AddCommentCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 12.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddCommentCell.h"

@interface AddCommentCell() <UITextViewDelegate>

// methods
- (IBAction) onAddAttachmentsBtn: (UIButton*) sender;

@end

@implementation AddCommentCell

#pragma mark - Actions -

- (IBAction) onAddAttachmentsBtn: (UIButton*) sender
{
    
}

#pragma mark - UITextViewDelegate -

- (void)textViewDidChange:(UITextView *)textView
{
    if ([self.delegate respondsToSelector:@selector( addCommentCell:
                                            newCommentTextDidChange: )])
    {
        [self.delegate addCommentCell: self
              newCommentTextDidChange: textView];
    }
}

@end
