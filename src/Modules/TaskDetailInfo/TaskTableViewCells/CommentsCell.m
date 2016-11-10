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

// Helpers
#import "NSDate+Helper.h"

@interface CommentsCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView*        userAvatarImageView;
@property (weak, nonatomic) IBOutlet UIButton*               editCommentBtn;
@property (weak, nonatomic) IBOutlet UILabel*                userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel*                commentDateLabel;
@property (weak, nonatomic) IBOutlet UITextView*             commentContentTextView;
@property (strong, nonatomic) FlexibleViewsContainer* attachmentsContainerView;


// properties

// methods


@end

@implementation CommentsCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskRowContent*) content
                   withWidth: (CGFloat)         width
                withDelegate: (id)              delegate
{
    self.delegate = delegate;
    
    [self.userAvatarImageView setImage: content.commentAuthorAvatar];
    
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
                                 self.commentContentTextView.frame.size.height + 25;
            CGFloat containerWidth = width - 30;
            CGFloat containerHeight = content.containerView.frame.size.height;
            
            CGRect containerFrame = CGRectMake(containerX, containerY, containerWidth, containerHeight);
            
            self.attachmentsContainerView = content.containerView;
            
            self.attachmentsContainerView.frame = containerFrame;
            
            [self addSubview: self.attachmentsContainerView];
        }
        
    }
}


#pragma mark - Internal -

- (NSArray*) createAttachmentsViewsWithTitles: (NSArray*) attachmentsArray
{
    __block NSMutableArray* viewsArray = [NSMutableArray new];
    
    [attachmentsArray enumerateObjectsUsingBlock: ^(NSString* title, NSUInteger idx, BOOL * _Nonnull stop) {
       
        AttachmentView* view = [[[NSBundle mainBundle] loadNibNamed: @"AttachmentView"
                                                              owner: nil
                                                            options: nil] lastObject];
        
        [view fillViewWithAttachmentName: title];
        
        [viewsArray addObject: view];
    }];
    
    return viewsArray.copy;
}


@end
