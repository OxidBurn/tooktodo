
//
//  LogCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"

@interface LogCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel*         logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel*         logDateLabel;

// properties


// methods


@end

@implementation LogCell


#pragma mark - Public -

- (void) fillLogCellWithText: (NSAttributedString*) text
                    withDate: (NSString*) date
              withUserAvatar: (NSString*) avatarSrc
{    
    self.logInfoLabel.attributedText = text;
    self.logDateLabel.text = date;
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: avatarSrc]];
}


@end
