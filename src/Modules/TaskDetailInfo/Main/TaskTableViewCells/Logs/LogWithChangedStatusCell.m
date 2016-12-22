//
//  LogWithChangedStatusCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithChangedStatusCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"
#import "TaskStatusDefaultValues.h"

@interface LogWithChangedStatusCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel* logDateLabel;

@property (weak, nonatomic) IBOutlet UIView*      firstStatusMarkView;
@property (weak, nonatomic) IBOutlet UIImageView* firstStatusMarkImageView;
@property (weak, nonatomic) IBOutlet UILabel*     firstStatusTextLabel;

@property (weak, nonatomic) IBOutlet UIView*      secondStatusMarkView;
@property (weak, nonatomic) IBOutlet UIImageView* secondStatusMarkImageView;
@property (weak, nonatomic) IBOutlet UILabel*     secondStatusTextLabel;

@property (weak, nonatomic) IBOutlet UIImageView* arrowSentImageView;

// properties


// methods

@end

@implementation LogWithChangedStatusCell


#pragma mark - Public -

- (void) fillLogCellWithContent: (LogsContent*) logContent
{
    self.logInfoLabel.attributedText = logContent.logText;
    self.logDateLabel.text           = logContent.createdDate;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: logContent.avatarSrs]];
    
    self.firstStatusMarkImageView.image      = [[TaskStatusDefaultValues sharedInstance]
                                                returnIconImageForTaskStatus: logContent.oldTaskStatus];
    self.firstStatusTextLabel.text           = [[TaskStatusDefaultValues sharedInstance]
                                                returnTitleForTaskStatus: logContent.oldTaskStatus];
    self.firstStatusMarkView.backgroundColor = [[TaskStatusDefaultValues sharedInstance]
                                                returnColorForTaskStatus: logContent.oldTaskStatus];
    self.firstStatusTextLabel.textColor      = [[TaskStatusDefaultValues sharedInstance]
                                                returnFontColorForTaskStatus: logContent.oldTaskStatus];
    
    self.secondStatusMarkImageView.image      = [[TaskStatusDefaultValues sharedInstance]
                                                 returnIconImageForTaskStatus: logContent.updatedTaskStatus];
    self.secondStatusTextLabel.text           = [[TaskStatusDefaultValues sharedInstance]
                                                 returnTitleForTaskStatus: logContent.updatedTaskStatus];
    self.secondStatusMarkView.backgroundColor = [[TaskStatusDefaultValues sharedInstance]
                                                 returnColorForTaskStatus: logContent.updatedTaskStatus];
    self.secondStatusTextLabel.textColor      = [[TaskStatusDefaultValues sharedInstance]
                                                 returnFontColorForTaskStatus: logContent.updatedTaskStatus];
}


@end
