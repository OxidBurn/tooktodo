//
//  TeamProfilesInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/31/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamProfilesInfoViewController.h"

// Frameworks
#import "ReactiveCocoa.h"

//Classes
#import "AvatarImageView.h"
#import "TeamProfileInfoViewModel.h"
#import "TeamMember.h"
#import "Utils.h"
#import "RolesViewController.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"

@interface TeamProfilesInfoViewController () <TeamProfileViewModelDelegate>

// properties
@property (weak, nonatomic) IBOutlet AvatarImageView* avatarImgView;

@property (weak, nonatomic) IBOutlet UILabel* nameLabel;

@property (weak, nonatomic) IBOutlet UITableView* profileTableView;

@property (nonatomic, strong) TeamProfileInfoViewModel* viewModel;


// methods

- (IBAction) onDismiss: (UIBarButtonItem*) sender;



@end

@implementation TeamProfilesInfoViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"КОМАНДА"
                                               withSubTitle: @"Квартира на Ходынке"];
    
    self.profileTableView.dataSource = self.viewModel;
    self.profileTableView.delegate   = self.viewModel;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear: animated];
    
    [self updateUserInfo];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties -

- (TeamProfileInfoViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [[TeamProfileInfoViewModel alloc] init];
        _viewModel.delegate = self;
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) updateUserInfo
{
    @weakify(self)
    
    [[self.viewModel updateInfo] subscribeNext: ^(TeamMember* teamMember) {
        
        @strongify(self)

        self.nameLabel.text      = [NSString stringWithFormat:@" %@ %@", teamMember.firstName, teamMember.lastName];
        
        self.avatarImgView.image = [UIImage imageWithContentsOfFile: [[Utils getAvatarsDirectoryPath]
                                            stringByAppendingString: teamMember.avatarPath]];
        
        [self.profileTableView reloadData];
        
    }];
}


#pragma mark - Acitons -

- (IBAction) onDismiss: (UIBarButtonItem*) sender
{
    // Need to call method in viewModel and model
    // for changing selected state in team member value
    
    [self.navigationController popViewControllerAnimated: YES];
}


#pragma mark - Segue -

- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    [super prepareForSegue: segue
                    sender: sender];
    
    
    if ([segue.identifier isEqualToString: @"ShowRolesForUser"])
    {
        RolesViewController* controller = segue.destinationViewController;
        
        [controller setRolesViewControllerDelegate: self.viewModel];
    }
    
}

#pragma mark - TeamProfileViewModelDelegate Methods -

- (void) showControllerWithIdentifier: (NSString*) segueID
{
    [self performSegueWithIdentifier: segueID
                              sender: self];
}

- (void) showDesignationAlert: (NSString*) userName
{
    UIAlertController* alertController = [UIAlertController alertControllerWithTitle: @"Назначить администратором"
                                                                             message: [NSString stringWithFormat:@"Изменить данные для пользователя %@", userName]
                                                                      preferredStyle: UIAlertControllerStyleAlert];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"Назначить"
                                                         style: UIAlertActionStyleDefault
                                                       handler: ^(UIAlertAction * _Nonnull action) {
                                                           NSLog(@"Пользователь %@ назначен администратором", userName);
                                                       }]];
    
    [alertController addAction: [UIAlertAction actionWithTitle: @"Отменить"
                                                         style: UIAlertActionStyleCancel
                                                       handler: ^(UIAlertAction * _Nonnull action) {
                                                           
                                                       }]];
    
    [self presentViewController: alertController
                       animated: YES
                     completion: nil ];
}

@end
