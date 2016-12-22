//
//  LogWithUpdatedStringValuesCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithUpdatedStringValuesCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"

@interface LogWithUpdatedStringValuesCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel* logDateLabel;

@property (weak, nonatomic) IBOutlet UILabel* logFirstDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel* logSecondDetailLabel;

// properties


// methods


@end

@implementation LogWithUpdatedStringValuesCell


#pragma mark - Public -

- (void) fillLogCellWithContent: (LogsContent*) logContent
{
    self.logInfoLabel.attributedText = logContent.logText;
    self.logDateLabel.text           = logContent.createdDate;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: logContent.avatarSrs]];
    
    self.logFirstDetailLabel.text  = logContent.oldTextValue;
    self.logSecondDetailLabel.text = logContent.updatedTextValue;
}


@end
