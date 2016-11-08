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
@property (weak, nonatomic) IBOutlet FlexibleViewsContainer* attachmentsContainerView;


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
    
    [self.attachmentsContainerView setTypeToViewsContainer: ViewForCommentCell];
    
    if ( content.attachmentsArray )
    {
        NSArray* viewsArray = [self createAttachmentsViewsWithTitles: content.attachmentsArray];
        
        [self.attachmentsContainerView fillViewsContainerWithViews: viewsArray
                                                    withCompletion: ^(BOOL isSuccess) {
            
                                                        CGRect frame = self.frame;
                                                        
                                                        CGFloat height = self.attachmentsContainerView.height + 97;
                                                        
                                                        frame.size.height = height;
                                                        
                                                        self.frame = frame;
        }];
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
