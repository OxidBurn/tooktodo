//
//  SingleUserInfoCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSSingleUserInfoCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "FilledTeamInfo.h"

@interface OSSingleUserInfoCell()

// properties
@property (weak, nonatomic) IBOutlet UIImageView *userAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *infoTitleLabel;


// methods


@end

@implementation OSSingleUserInfoCell

#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*) titleText
          withUserFullName: (NSString*) userFullName
            withUserAvatar: (NSString*) userAvatarSrc
{
    self.userNameLabel.text        = userFullName;
    self.infoTitleLabel.text       = titleText;
    
    // Setup image
    
    if ( userAvatarSrc.length > 0 )
    {
        [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: userAvatarSrc]];
    }
    else
    {
        self.userAvatarImageView.image = [UIImage imageNamed: @"emptyAvatarIcon"];
    }
    
    self.userAvatarImageView.layer.cornerRadius = 10;
    self.userAvatarImageView.clipsToBounds = YES;

}

@end
