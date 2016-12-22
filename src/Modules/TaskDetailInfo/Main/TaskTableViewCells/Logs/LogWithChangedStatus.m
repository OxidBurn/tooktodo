//
//  LogWithChangedStatus.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithChangedStatus.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"
#import "TaskStatusDefaultValues.h"

@interface LogWithChangedStatus()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel* logDateLabel;

@property (weak, nonatomic) IBOutlet UIView*      firstActionMarkView;
@property (weak, nonatomic) IBOutlet UIImageView* firstActionMarkImageView;
@property (weak, nonatomic) IBOutlet UILabel*     firstActionTextLabel;

@property (weak, nonatomic) IBOutlet UIView*      secondActionMarkView;
@property (weak, nonatomic) IBOutlet UIImageView* secondActionMarkImageView;
@property (weak, nonatomic) IBOutlet UILabel*     secondActionTextLabel;

// properties


// methods

@end

@implementation LogWithChangedStatus


#pragma mark - Public -

- (void) fillLogCellWithText: (NSAttributedString*) text
                    withDate: (NSString*)           date
              withUserAvatar: (NSString*)           avatarSrc
               withOldStatus: (NSUInteger)          oldStatus
               withNewStatus: (NSUInteger)          newStatus
{
    self.logInfoLabel.attributedText = text;
    self.logDateLabel.text = date;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: avatarSrc]];
    
    self.firstActionMarkImageView.image = [[TaskStatusDefaultValues sharedInstance] returnIconImageForTaskStatus: oldStatus];
    self.firstActionTextLabel.text = [[TaskStatusDefaultValues sharedInstance] returnTitleForTaskStatus: oldStatus];
    self.firstActionMarkView.backgroundColor = [[TaskStatusDefaultValues sharedInstance] returnColorForTaskStatus: oldStatus];
    self.firstActionTextLabel.textColor = [[TaskStatusDefaultValues sharedInstance] returnFontColorForTaskStatus: oldStatus];
    
    self.secondActionMarkImageView.image = [[TaskStatusDefaultValues sharedInstance] returnIconImageForTaskStatus: newStatus];
    self.secondActionTextLabel.text = [[TaskStatusDefaultValues sharedInstance] returnTitleForTaskStatus: newStatus];
    self.secondActionMarkView.backgroundColor = [[TaskStatusDefaultValues sharedInstance] returnColorForTaskStatus: newStatus];
    self.secondActionTextLabel.textColor = [[TaskStatusDefaultValues sharedInstance] returnFontColorForTaskStatus: newStatus];
}


@end
