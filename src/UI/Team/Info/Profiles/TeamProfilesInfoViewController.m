//
//  TeamProfilesInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/31/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamProfilesInfoViewController.h"

// Classes
#import "TeamProfilesInfoViewModel.h"
#import "AvatarImageView.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"

@interface TeamProfilesInfoViewController ()

// properties
@property (strong, nonatomic) TeamProfilesInfoViewModel* viewModel;

// outlets

@property (weak, nonatomic) IBOutlet AvatarImageView* teamMemberAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* teamMemberNameLabel;

@property (weak, nonatomic) IBOutlet UIButton* callToTeamMemberBtn;

@property (weak, nonatomic) IBOutlet UILabel* teamMemberPhoneNumberLabel;

@property (weak, nonatomic) IBOutlet UILabel* teamMemberEmailLabel;

@property (weak, nonatomic) IBOutlet UIButton* sendToteamMemberEmailBtn;

@property (weak, nonatomic) IBOutlet UILabel* teamMemberRoleLabel;

@property (weak, nonatomic) IBOutlet UILabel* teamMemberCompanyLabel;

@property (weak, nonatomic) IBOutlet UILabel* teamMemberPermissionLabel;


// methods
- (IBAction) onDismiss: (UIBarButtonItem*) sender;

- (IBAction) onChangeAvatarBtn: (UIButton*) sender;

@end

@implementation TeamProfilesInfoViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup navigation title view
//    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"КОМАНДА"
//                                               withSubTitle: @"Квартира на Ходынке"];

}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
//    self.tableView.dataSource = self.viewModel;
//    self.tableView.delegate   = self.viewModel;
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties -

- (TeamProfilesInfoViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [TeamProfilesInfoViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Acitons -

- (IBAction) onDismiss: (UIBarButtonItem*) sender
{
    // Need to call method in viewModel and model
    // for changing selected state in team member value
    
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onChangeAvatarBtn: (UIButton*) sender
{
    
}

@end
