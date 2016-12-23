//
//  LogWithCommentCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 22.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithCommentCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"
#import "ViewWithBorder.h"

@interface LogWithCommentCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel* logDateLabel;

@property (weak, nonatomic) IBOutlet UILabel* commentTextLabel;

@property (weak, nonatomic) IBOutlet ViewWithBorder* viewWithBorder;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* viewWithBorderHeight;

// properties


// methods


@end

@implementation LogWithCommentCell


#pragma mark - Public -

- (void) fillLogCellWithContent: (LogsContent*) logContent
{
    self.logInfoLabel.attributedText = logContent.logText;
    self.logDateLabel.text           = logContent.createdDate;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: logContent.avatarSrs]];
    
    self.commentTextLabel.text = logContent.commentText;
    
    // 38 is value of contraints to top and boddom
    self.viewWithBorderHeight.constant = logContent.sizeOfCommentLabel.height + 38;
    
    // handling cases when comment string value is nil
    if ( logContent.commentText == nil )
    {
        self.viewWithBorder.hidden = YES;
    }
}

@end
