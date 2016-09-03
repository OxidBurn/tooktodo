//
//  TeamInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamInfoViewController.h"

// Classes
#import "ProjectsControllersDelegate.h"
#import "MainTabBarController.h"
#import "TeamInfoViewModel.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"

@interface TeamInfoViewController ()

// Properties

// Outlets
@property (weak, nonatomic) IBOutlet UITableView* teamInfoTableView;
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;

@property (weak, nonatomic) id<ProjectsControllersDelegate> delegate;

@property (strong, nonatomic) TeamInfoViewModel* viewModel;
@property (nonatomic, strong) InviteInfo* inviteInfo;

// Methods

- (void) setupTableView;

- (void) bindingUI;

@end

@implementation TeamInfoViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // setup delegate
    self.delegate = (MainTabBarController*)self.navigationController.parentViewController;
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"КОМАНДА"
                                               withSubTitle: @"Квартира на Ходынке"];
    
    // Binding controller UI
    [self bindingUI];
}

- (void) viewDidAppear: (BOOL) animated
{
    [super viewDidAppear: animated];
    
    // Hide search bar on show
    [self setupTableView];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    // Update team info when appeared screen
    // made for immediate update team info after
    // switching between projects or adding new member to the team
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel updateInfoWithCompletion: ^(BOOL isSuccess) {
       
        if ( isSuccess )
        {
            [blockSelf.teamInfoTableView reloadData];
        }
        
    }];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Properties -

- (TeamInfoViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [[TeamInfoViewModel alloc] init];
    }
    
    return _viewModel;
}

#pragma mark - Public mehtods -

- (void) fillInviteInfo: (InviteInfo*) userInf
{
    self.inviteInfo = userInf;
}


#pragma mark - Internal methods -

- (void) setupTableView
{
    [self.teamInfoTableView setContentOffset: CGPointMake(0, self.searchBar.height)];
}

- (void) bindingUI
{
    self.teamInfoTableView.dataSource = self.viewModel;
    self.teamInfoTableView.delegate   = self.viewModel;
    self.searchBar.delegate           = self.viewModel;
}

#pragma mark - Actions -

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    if ( [self.delegate respondsToSelector: @selector(showMainMenu)] )
    {
        [self.delegate showMainMenu];
    }
}

@end
