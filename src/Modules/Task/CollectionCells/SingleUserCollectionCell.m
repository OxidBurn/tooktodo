//
//  SingleUserCollectionCell.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SingleUserCollectionCell.h"

// Classes
#import "AvatarImageView.h"
#import "FilledTeamInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SingleUserCollectionCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* userRoleLabel;

@property (weak, nonatomic) IBOutlet UILabel* userNameLabel;

@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UIImageView* userMarkImageView;

// properties


// methods


@end

@implementation SingleUserCollectionCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskCollectionCellsContent*) content
{
    self.userRoleLabel.text = content.cellTitle;
    
    FilledTeamInfo* owner = content.taskOwner.firstObject;
    
    self.userNameLabel.text = owner.fullname;
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: owner.avatarSrc]];
}
@end
