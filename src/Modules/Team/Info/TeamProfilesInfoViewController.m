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

// Categories
#import "BaseMainViewController+NavigationTitle.h"

//Classes
#import "AvatarImageView.h"
#import "TeamProfileInfoViewModel.h"
#import "TeamMember.h"
#import "Utils.h"
#import "RolesViewController.h"

@interface TeamProfilesInfoViewController () <TeamProfileViewModelDelegate>

// Properties
@property (nonatomic, strong) TeamProfileInfoViewModel* viewModel;

// Outlets
@property (weak, nonatomic) IBOutlet UITableView* profileInfoTableView;

@property (weak, nonatomic) IBOutlet AvatarImageView* profileAvatarImageView;

@property (weak, nonatomic) IBOutlet UILabel* profileFullNameLabel;

// Methods
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
    
    self.profileInfoTableView.dataSource = self.viewModel;
    self.profileInfoTableView.delegate   = self.viewModel;
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    [self updateUserInfo];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
    }
    
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

#pragma mark - Acitons -

- (IBAction) onDismiss: (UIBarButtonItem*) sender
{
    // Need to call method in viewModel and model
    // for changing selected state in team member value
    
    [self.navigationController popViewControllerAnimated: YES];
}


#pragma mark - Internal methods -

- (void) updateUserInfo
{
    @weakify(self)
    
    [[self.viewModel updateInfo] subscribeNext: ^(TeamMember* teamMember) {
        
        @strongify(self)
        
        self.profileFullNameLabel.text      = [NSString stringWithFormat:@" %@ %@", teamMember.firstName, teamMember.lastName];
        
        self.profileAvatarImageView.image = [UIImage imageWithContentsOfFile: [[Utils getAvatarsDirectoryPath]
                                                                               stringByAppendingString: teamMember.avatarPath]];
        
        [self.profileInfoTableView reloadData];
        
    }];
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
