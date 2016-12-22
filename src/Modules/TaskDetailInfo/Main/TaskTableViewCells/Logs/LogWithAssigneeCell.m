//
//  LogWithAssigneeCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 22.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithAssigneeCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"

@interface LogWithAssigneeCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel* logDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *oldUserNameLabel;
@property (weak, nonatomic) IBOutlet AvatarImageView *oldUserAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowSendImageView;
@property (weak, nonatomic) IBOutlet UILabel *updatedUserNameLabel;
@property (weak, nonatomic) IBOutlet AvatarImageView *updatedUserAvatarImageView;

// properties


// methods


@end

@implementation LogWithAssigneeCell


#pragma mark - Public -

- (void) fillLogCellWithContent: (LogsContent*) logContent
{
    self.logInfoLabel.attributedText = logContent.logText;
    self.logDateLabel.text           = logContent.createdDate;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: logContent.avatarSrs]];
    
}

@end
