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
#import "FlexibleViewsContainer.h"
#import "AttachmentView.h"
#import <SDWebImage/UIImageView+WebCache.h>

// Helpers
#import "NSDate+Helper.h"

@interface CommentsCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView*    userAvatarImageView;
@property (weak, nonatomic) IBOutlet UIButton*           editCommentBtn;
@property (weak, nonatomic) IBOutlet UILabel*            userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel*            commentDateLabel;
@property (weak, nonatomic) IBOutlet UITextView*         commentContentTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* TextViewHeightConstraint;
@property (strong, nonatomic) FlexibleViewsContainer*    attachmentsContainerView;
@property (weak, nonatomic) IBOutlet UIButton *editBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;


// properties

// methods
- (IBAction) onEditComment: (UIButton*) sender;


@end

@implementation CommentsCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskRowContent*) content
                   withWidth: (CGFloat)         width
                withDelegate: (id)              delegate
{
    self.userAvatarImageView.clipsToBounds = YES;
    [self.userAvatarImageView.layer setCornerRadius: 10];
    
    self.TextViewHeightConstraint.constant = content.commentTextViewHeight;
    
    self.delegate = delegate;
    
    if ( content.commentAuthorAvatar )
        [self.userAvatarImageView setImage: content.commentAuthorAvatar];
    else
        [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: content.commentAuthorAvatarSrc]];
    
    self.userNameLabel.text = content.commentAuthorName;
    
    self.commentDateLabel.text = [NSDate stringFromDate: content.commentDate];
    
    self.commentContentTextView.text = content.commentText;
    
    [self.attachmentsContainerView setTypeToViewsContainer: ViewForCommentCell];
    
    if ( content.containerView )
    {
        if ( self.attachmentsContainerView == nil )
        {
            CGFloat containerX = self.commentContentTextView.frame.origin.x;
            CGFloat containerY = self.commentContentTextView.frame.origin.y +
                                 content.commentTextViewHeight + 18;
            CGFloat containerWidth = width - 30;
            CGFloat containerHeight = content.containerView.frame.size.height;
            
            CGRect containerFrame = CGRectMake(containerX, containerY, containerWidth, containerHeight);
            
            self.attachmentsContainerView = content.containerView;
            
            self.attachmentsContainerView.frame = containerFrame;
            
            [self addSubview: self.attachmentsContainerView];
        }
        
    }
}


#pragma mark - Action -

- (IBAction)onCancelBtn:(UIButton *)sender
{
    
}

- (IBAction)onEditBtn:(UIButton *)sender
{
    
}

- (IBAction)onEditComment:(UIButton *)sender
{
    
}
@end
