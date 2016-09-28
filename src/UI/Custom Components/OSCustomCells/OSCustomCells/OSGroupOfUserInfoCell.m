//
//  GroupOfUserInfoCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSGroupOfUserInfoCell.h"

@interface OSGroupOfUserInfoCell()

// properties
@property (weak, nonatomic) IBOutlet UIImageView*        firstAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView*        secondAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView*        thirdAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView*        forthAvatarImageView;
@property (weak, nonatomic) IBOutlet UIImageView*        fifthAvatarImageView;
@property (weak, nonatomic) IBOutlet UILabel*            numberOfUsersLeftLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* firstAvatarTrailingConstraint;
@property (weak, nonatomic) IBOutlet UILabel*            groupTitleLabel;

// methods


@end

@implementation OSGroupOfUserInfoCell

#pragma mark - Public -

- (void) fillCellWithTitle: (NSString*) titleText
{
    self.groupTitleLabel.text = titleText;
}


@end
