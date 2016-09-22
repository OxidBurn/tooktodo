//
//  TeamInfoTableViewCell.m
//  TookTODO
//
//  Created by Глеб on 03.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamInfoTableViewCell.h"

// Frameworks
#import <SDWebImage/UIImageView+WebCache.h>

// Classes
#import "Utils.h"
#import "ProjectTaskAssignee+CoreDataClass.h"
#import "ProjectInviteInfo+CoreDataClass.h"
#import "FilledTeamInfo.h"

typedef NS_ENUM(NSInteger, PermissionType)
{
    SystemAdministrator = -1,
    Participant = 0,
    Owner = 1,
    Administrator = 2,
};

@interface TeamInfoTableViewCell()

// properties

//@property (nonatomic, strong) FilledTeamInfo* teamInfo;

// outlets

@property (weak, nonatomic) IBOutlet UIImageView* teamMemberAvatar;

@property (weak, nonatomic) IBOutlet UILabel* teamMemberName;

@property (weak, nonatomic) IBOutlet UILabel* teamMemberPermission;

@property (weak, nonatomic) IBOutlet UIButton* sendEmailToTeamMemberBtn;

@property (weak, nonatomic) IBOutlet UIButton* callToTeamMemberBtn;

// methods

- (IBAction) onCallToTeamMemberBtn: (UIButton*) sender;

- (IBAction) onSendEmailToTeamMemberBtn: (UIButton*) sender;

@end

@implementation TeamInfoTableViewCell


#pragma mark - Actions -

- (IBAction) onCallToTeamMemberBtn: (UIButton*) sender
{
    if ( [self.delegate respondsToSelector: @selector(didTriggerCallActionAtIndex:)] )
    {
        [self.delegate didTriggerCallActionAtIndex: sender.tag];
    }
}

- (IBAction) onSendEmailToTeamMemberBtn: (UIButton*) sender
{
    if ([self.delegate respondsToSelector: @selector(didTriggerEmailActionIndex:)])
    {
        [self.delegate didTriggerEmailActionIndex: sender.tag];
    }
}

#pragma mark - Public -

- (void) fillCellWithInfo: (FilledTeamInfo*) teamInfo
             forIndexPath: (NSIndexPath*)    indexPath
{
    self.callToTeamMemberBtn.tag      = indexPath.row;
    self.sendEmailToTeamMemberBtn.tag = indexPath.row;
    
    [self checkIfPhoneNumberExists: teamInfo];
    [self chechIfEmailExists:       teamInfo];

    [self.teamMemberAvatar sd_setImageWithURL: [NSURL URLWithString: teamInfo.avatarSrc]];
    
    self.teamMemberName.text       = [NSString stringWithFormat: @"%@, %@", teamInfo.fullname, teamInfo.role];
    
    self.teamMemberPermission.text = [self setPermission: teamInfo.projectPermission.integerValue];
    
}

#pragma mark - Helpers -

- (void) checkIfPhoneNumberExists: (FilledTeamInfo*) teamInfo
{
    if ( [teamInfo.phoneNumber isEqualToString: @""])
    {
        self.callToTeamMemberBtn.hidden = YES;
    }
}

- (void) chechIfEmailExists: (FilledTeamInfo*) teamInfo
{
    if ( [teamInfo.email isEqualToString: @""] )
    {
        self.sendEmailToTeamMemberBtn.hidden = YES;
    }
}

- (NSString*) setPermission: (NSUInteger) permission
{
    switch (permission)
    {
        case SystemAdministrator:
            return @"Системный администратор";
            break;
        case Participant:
            return @"Участник проекта";
            break;
        case Owner:
            return @"Владелец";
            break;
        case Administrator:
            return @"Адмиистратор";
            break;
            
        default:
            break;
    }
    
    return @"";
}

@end
