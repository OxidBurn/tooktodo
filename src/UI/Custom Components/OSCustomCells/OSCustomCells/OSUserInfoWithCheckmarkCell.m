//
//  OSUserInfoWithCheckmarkCell.m
//  TookTODO
//
//  Created by Глеб on 22.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSUserInfoWithCheckmarkCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

@interface OSUserInfoWithCheckmarkCell()

// properties

// outlets

@property (weak, nonatomic) IBOutlet UIImageView* checkMarkImageView;

@property (weak, nonatomic) IBOutlet UIImageView* userAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel*     userInfoTextLabel;

// methods


@end

@implementation OSUserInfoWithCheckmarkCell

#pragma mark - Public -

- (void) fillCellWithFilledMemberInfo: (FilledTeamInfo*) memberInfo
{
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: memberInfo.avatarSrc]];
    
    NSString* userInfo = [NSString stringWithFormat: @"%@, %@", memberInfo.fullname, memberInfo.role];
    
    self.userInfoTextLabel.text = userInfo;
    
    self.checkMarkImageView.hidden = memberInfo.isResponsible ? NO : YES;
    
}

- (void) changeCheckmarkState: (BOOL) state
{
    self.checkMarkImageView.hidden = state ? NO : YES;
}

- (BOOL) currentCheckMarkState
{
    return self.checkMarkImageView.hidden;
}

@end
