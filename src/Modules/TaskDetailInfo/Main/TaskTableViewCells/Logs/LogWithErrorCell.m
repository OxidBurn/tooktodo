//
//  LogWithErrorCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 22.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithErrorCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"

@interface LogWithErrorCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel* logDateLabel;
@property (weak, nonatomic) IBOutlet UILabel *errorTextLabel;

// properties


// methods


@end

@implementation LogWithErrorCell


#pragma mark - Public -

- (void) fillLogCellWithContent: (LogsContent*) logContent
{
    self.logInfoLabel.attributedText = logContent.logText;
    self.logDateLabel.text           = logContent.createdDate;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: logContent.avatarSrs]];
    
}

@end
