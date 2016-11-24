//
//  OSUserInfoWithCheckmarkCell.m
//  TookTODO
//
//  Created by Nikolay Chaban on 22.09.16.
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
                        withCheckmark: (BOOL)            isSelected
{
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: memberInfo.avatarSrc]];
    self.userAvatarImageView.clipsToBounds = YES;
    self.userAvatarImageView.layer.cornerRadius = 10;
    
    NSString* userInfo = [NSString stringWithFormat: @"%@, %@", memberInfo.fullname, memberInfo.role];
    
    self.userInfoTextLabel.text = userInfo;
    
    self.checkMarkImageView.hidden = !isSelected;
    
}

- (void) fillCellWithAssignee: (ProjectTaskAssignee*) assignee
                withCheckMark: (BOOL)                 isSelected
{
    NSString* urlString = assignee.avatarSrc;
    
    if ( [assignee.avatarSrc containsString: @"http://api.taketowork.com"] == NO )
    {
        urlString = [NSString stringWithFormat: @"http://api.taketowork.com%@", assignee.avatarSrc];
    }
    
    [self.userAvatarImageView sd_setImageWithURL: [NSURL URLWithString: urlString]];
    self.userAvatarImageView.clipsToBounds = YES;
    self.userAvatarImageView.layer.cornerRadius = 10;
    
    NSString* userInfo = [NSString stringWithFormat: @"%@ %@", assignee.firstName, assignee.lastName];
    
    self.userInfoTextLabel.text = userInfo;
    
    self.checkMarkImageView.hidden = !isSelected;
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
