
//
//  LogCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogDefaultCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"

@interface LogDefaultCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel*         logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel*         logDateLabel;

// properties


// methods


@end

@implementation LogDefaultCell


#pragma mark - Public -

- (void) fillLogCellWithContent: (LogsContent*) content
{    
    self.logInfoLabel.attributedText = content.logText;
    self.logDateLabel.text           = content.createdDate;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: content.avatarSrs]];
}


@end
