//
//  SingleUserInfoCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSSingleUserInfoCell.h"

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
            withUserAvatar: (UIImage*) userAvatar
{
    self.userNameLabel.text        = userFullName;
    self.infoTitleLabel.text       = titleText;
    self.userAvatarImageView.image = userAvatar;
}

@end
