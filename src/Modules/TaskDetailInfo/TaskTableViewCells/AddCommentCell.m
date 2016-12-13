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

- (void) textViewDidBeginEditing: (UITextView*) textView
{
    self.addCommentLabel.alpha = 0;
}

- (void) textViewDidEndEditing: (UITextView*) textView
{
    self.addCommentLabel.alpha = textView.text.length == 0;
}

- (BOOL)        textView: (UITextView*)textView
 shouldChangeTextInRange: (NSRange)range
         replacementText: (NSString *)text
{
    if ([text isEqualToString: @"\n"])
    {
        if ([self.delegate respondsToSelector:@selector( addCommentCell:
                                                            onSendClick: )])
        {
            [self.delegate addCommentCell: self
                              onSendClick: textView];
        }
        [textView resignFirstResponder];
        return NO;
    }
    
    BOOL shouldReturn = YES;
    
    if ( textView.text.length > 1999 && text.length > 0)
    {
        text = @"";
        
        shouldReturn = NO;
    }
    
    return shouldReturn;
}

- (void) textViewDidChange: (UITextView*) textView
{
    if ([self.delegate respondsToSelector: @selector( addCommentCell:
                                            newCommentTextDidChange: )])
    {
        [self.delegate addCommentCell: self
              newCommentTextDidChange: textView];
    }
}

@end
