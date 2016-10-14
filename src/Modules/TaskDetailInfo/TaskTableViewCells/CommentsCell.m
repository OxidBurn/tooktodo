//
//  CommentsCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CommentsCell.h"

// Classes
#import "AvatarImageView.h"

// Helpers
#import "NSDate+Helper.h"

@interface CommentsCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;
@property (weak, nonatomic) IBOutlet UIButton*        editCommentBtn;
@property (weak, nonatomic) IBOutlet UILabel*         userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel*         commentDateLabel;
@property (weak, nonatomic) IBOutlet UITextView*      commentContentTextView;


// properties

// methods


@end

@implementation CommentsCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskRowContent*) content
{
    [self.userAvatarImageView setImage: content.commentAuthorAvatar];
    
    self.userNameLabel.text = content.commentAuthorName;
    
    self.commentDateLabel.text = [NSDate stringFromDate: content.commentDate];
    
    self.commentContentTextView.text = content.commentText;
    
}

@end
