//
//  LogWithDetailCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LogWithDetailCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "AvatarImageView.h"

@interface LogWithDetailCell()

// outlets
@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* logInfoLabel;
@property (weak, nonatomic) IBOutlet UILabel* logDateLabel;

@property (weak, nonatomic) IBOutlet UILabel* logFirstDetailLabel;
@property (weak, nonatomic) IBOutlet UILabel* logSecondDetailLabel;

// properties


// methods


@end

@implementation LogWithDetailCell


#pragma mark - Public -

- (void) fillLogCellWithText: (NSString*) text
                    withDate: (NSString*) date
              withUserAvatar: (NSString*) avatarSrc
                withOldTerms: (NSString*) oldTerms
                withNewTerms: (NSString*) newTerms
{
    self.logInfoLabel.text = text;
    self.logDateLabel.text = date;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: avatarSrc]];
    
    self.logFirstDetailLabel.text  = oldTerms;
    self.logSecondDetailLabel.text = newTerms;
}


@end
