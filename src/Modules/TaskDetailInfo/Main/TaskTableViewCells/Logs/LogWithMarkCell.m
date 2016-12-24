//
//  LogWithMarkCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 24.12.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithMarkCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"
#import "Utils.h"

@interface LogWithMarkCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel* logDateLabel;

// properties


// methods


@end

@implementation LogWithMarkCell


#pragma mark - Public -


- (void) fillLogCellWithContent: (LogsContent*) logContent
{
    self.logDateLabel.text           = logContent.createdDate;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: logContent.avatarSrs]];
    
    
    NSTextAttachment* iconAttachment = [[NSTextAttachment alloc] init];
    
    iconAttachment.image = [UIImage imageNamed: @"Overdue"];
    iconAttachment.bounds = CGRectMake(5, -3, 14, 14);
    
    NSAttributedString* attributedString = [NSAttributedString attributedStringWithAttachment: iconAttachment];
    
    NSMutableAttributedString* string = logContent.logText.mutableCopy;
    
    [string appendAttributedString: attributedString];
    
    self.logInfoLabel.attributedText = string;
    self.logInfoLabel.textAlignment  = UIControlContentVerticalAlignmentCenter;
}


@end
