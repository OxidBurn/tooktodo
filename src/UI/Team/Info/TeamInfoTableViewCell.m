//
//  TeamInfoTableViewCell.m
//  TookTODO
//
//  Created by Глеб on 03.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamInfoTableViewCell.h"

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
    
}

- (IBAction) onSendEmailToTeamMemberBtn: (UIButton*) sender
{
    
}

#pragma mark - Public -

- (void) fillCellWithInfo: (TeamMember*) teamMember
             forIndexPath: (NSIndexPath*) indexPath
{
    self.callToTeamMemberBtn.tag      = indexPath.row;
    self.sendEmailToTeamMemberBtn.tag = indexPath.row;
    
    NSString* teamMemberFullName = [NSString stringWithFormat: @"%@ %@", teamMember.firstName,
                                                                         teamMember.lastName];
    NSString* teamMemberPosition = teamMember.comment;
    
    NSString* teamMemberCompany  = teamMember.company;
    
    
    [self checkIfPhoneNumberExists: teamMember];
    [self chechIfEmailExists:       teamMember];
    
    self.teamMemberName.text       = [NSString stringWithFormat: @"%@, %@", teamMemberFullName, teamMemberPosition];
    self.teamMemberPermission.text = [NSString stringWithFormat: @"!Права доступа!, %@", teamMemberCompany];
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
