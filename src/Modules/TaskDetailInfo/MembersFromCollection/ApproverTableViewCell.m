//
//  ApproverTableViewCell.m
//  TookTODO
//
//  Created by Lera on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ApproverTableViewCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

@interface ApproverTableViewCell()

// properties
@property (weak, nonatomic) IBOutlet UIImageView* avatarImgView;
@property (weak, nonatomic) IBOutlet UIImageView* checkMarkImgView;
@property (weak, nonatomic) IBOutlet UILabel*     userNameImgView;

// methods

@end

@implementation ApproverTableViewCell

- (void) fillCellWithApproverUser: (FilledTeamInfo*)   approver
       withApprovedCheckmarkState: (BOOL)              approvedState
{
    self.userNameImgView.text = [NSString stringWithFormat: @"%@ %@", approver.firstName, approver.lastName];
    
    if ([approver respondsToSelector: @selector(avatarSrc)])
    {
         [self.avatarImgView sd_setImageWithURL: [NSURL URLWithString: approver.avatarSrc]];
    }
    
    else
        self.avatarImgView.image = [UIImage imageNamed: @"emptyAvatarIcon"];
    
    [self handleApprovedMarkForUser: approvedState];
}

- (void) handleApprovedMarkForUser: (BOOL) approved
{
    if (approved)
        self.checkMarkImgView.image = [UIImage imageNamed: @"GreenChack"];
    
    else
        self.checkMarkImgView.image = [UIImage imageNamed: @"PencilChack"];
}

@end
