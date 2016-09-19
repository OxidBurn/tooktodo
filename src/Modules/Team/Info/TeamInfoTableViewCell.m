//
//  TeamInfoTableViewCell.m
//  TookTODO
//
//  Created by Глеб on 03.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamInfoTableViewCell.h"

// Classes
#import "Utils.h"

@interface TeamInfoTableViewCell()

// properties


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

- (void) fillCellWithInfo: (TeamMember*) teamMember
             forIndexPath: (NSIndexPath*) indexPath
{
    self.callToTeamMemberBtn.tag      = indexPath.row;
    self.sendEmailToTeamMemberBtn.tag = indexPath.row;
    
    NSString* teamMemberFirstName = (teamMember.firstName.length > 0) ? teamMember.firstName : @"";
    
    NSString* teamMemberLastName  = (teamMember.lastName.length > 0) ? teamMember.lastName : @"";
    
    NSString* teamMemberFullName = [NSString stringWithFormat: @"%@ %@", teamMemberFirstName,
                                                                         teamMemberLastName];
    NSString* teamMemberPosition = (teamMember.comment.length > 0) ? [NSString stringWithFormat: @", %@", teamMember.comment] : @"";
    
    NSString* teamMemberCompany  = (teamMember.company.length > 0) ? [NSString stringWithFormat: @", %@",teamMember.company] : @"";
    
    
    [self checkIfPhoneNumberExists: teamMember];
    [self chechIfEmailExists:       teamMember];
    
    self.teamMemberAvatar.image    = [UIImage imageWithContentsOfFile: [[Utils getAvatarsDirectoryPath] stringByAppendingString: teamMember.avatarPath]];
    self.teamMemberName.text       = [NSString stringWithFormat: @"%@%@", teamMemberFullName, teamMemberPosition];
    self.teamMemberPermission.text = [NSString stringWithFormat: @"!Права доступа!%@", teamMemberCompany];
}

#pragma mark - Helpers -

- (void) checkIfPhoneNumberExists: (TeamMember*) teamMember
{
    if ( teamMember.phoneNumber == nil )
    {
        self.callToTeamMemberBtn.hidden = YES;
    }
}

- (void) chechIfEmailExists: (TeamMember*) teamMember
{
    if ( teamMember.email == nil )
    {
        self.sendEmailToTeamMemberBtn.hidden = YES;
    }
}

@end
