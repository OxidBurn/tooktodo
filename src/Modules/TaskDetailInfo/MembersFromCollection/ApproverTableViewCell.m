//
//  ApproverTableViewCell.m
//  TookTODO
//
//  Created by Lera on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ApproverTableViewCell.h"
#import "FilledTeamInfo.h"

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

- (void) fillCellWithApproverUser: (ProjectRoleAssignments*) approver
{
    FilledTeamInfo* approverUser = [FilledTeamInfo new];
    
    [approverUser fillTeamInfo: approver];
    
    [self.avatarImgView sd_setImageWithURL: [NSURL URLWithString: approverUser.avatarSrc]];
}

@end
