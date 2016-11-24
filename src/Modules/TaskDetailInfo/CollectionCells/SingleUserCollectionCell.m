//
//  SingleUserCollectionCell.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SingleUserCollectionCell.h"

// Classes
#import "AvatarImageView.h"
#import "FilledTeamInfo.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface SingleUserCollectionCell()

// outlets
@property (weak, nonatomic) IBOutlet UILabel*         userRoleLabel;

@property (weak, nonatomic) IBOutlet UILabel*         userNameLabel;

@property (weak, nonatomic) IBOutlet AvatarImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UIImageView*     userMarkImageView;

// properties


// methods


@end

@implementation SingleUserCollectionCell

#pragma mark - Public -

- (void) fillCellWithContent: (TaskCollectionCellsContent*) content
{
    self.userRoleLabel.text = content.cellTitle;
    
    FilledTeamInfo* userInfo = nil;
    
    if ( content.taskOwner )
        userInfo = content.taskOwner.firstObject;
    else if (content.responsible)
        userInfo = content.responsible.firstObject;
    else if (content.claiming)
        userInfo = content.claiming.firstObject;
    else if (content.observers)
        userInfo = content.observers.firstObject;
    
    self.userNameLabel.text = [NSString stringWithFormat: @"%@ %@", userInfo.firstName, userInfo.lastName];
    
    if ([userInfo respondsToSelector:@selector(avatarSrc)])
    {
        [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: userInfo.avatarSrc]];
    }

    else
    {
        self.userAvatarImageView.image = [UIImage imageNamed: @"emptyAvatarIcon"];
    }
    
}


#pragma mark - Helpers -

- (void) handleApprovedMarkForContent: (TaskCollectionCellsContent*) content
{
    if (content.claiming.firstObject)
    {
        
    }
}
@end
