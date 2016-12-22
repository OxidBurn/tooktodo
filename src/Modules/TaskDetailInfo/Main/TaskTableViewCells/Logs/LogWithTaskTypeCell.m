//
//  LogWithTaskTypeCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 22.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithTaskTypeCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"
#import "RoundedView.h"

@interface LogWithTaskTypeCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel* logDateLabel;

@property (weak, nonatomic) IBOutlet UILabel *oldTypeTextLabel;

@property (weak, nonatomic) IBOutlet UILabel *updatedTypeTextValue;

@property (weak, nonatomic) IBOutlet UIImageView *arrowSendImageView;
@property (weak, nonatomic) IBOutlet RoundedView *oldTypeView;
@property (weak, nonatomic) IBOutlet RoundedView *updatedTypeView;

// properties


// methods


@end

@implementation LogWithTaskTypeCell


#pragma mark - Public -

- (void) fillLogCellWithContent: (LogsContent*) logContent
{
    self.logInfoLabel.attributedText = logContent.logText;
    self.logDateLabel.text           = logContent.createdDate;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: logContent.avatarSrs]];
    
    
}


@end
