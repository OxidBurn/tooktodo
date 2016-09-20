//
//  MainMenuViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "MainMenuViewController.h"

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "MainMenuViewModel.h"
#import "MainTabBarController.h"
#import "ProjectsControllersDelegate.h"

@interface MainMenuViewController ()

// properties

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel     *userNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *projectsTableView;
@property (weak, nonatomic) IBOutlet UIButton    *showHelpBtn;
@property (weak, nonatomic) IBOutlet UIButton    *supportBtn;
@property (weak, nonatomic) IBOutlet UIButton    *reviewBtn;

@property (weak, nonatomic) id<ProjectsControllersDelegate> delegate;

@property (strong, nonatomic) MainMenuViewModel* viewModel;

// methods

- (void) bindingUI;

- (IBAction) showWelcomeTour: (UIButton*) sender;

@end

@implementation MainMenuViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Set delegate
    self.delegate = (MainTabBarController*)self.slidingViewController.topViewController;
    
    // Binding all UI with model
    [self bindingUI];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    [self updateInfo];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (MainMenuViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [MainMenuViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Bindings -

- (void) bindingUI
{
    // Actions
    self.supportBtn.rac_command = self.viewModel.supportActionCommand;
    self.reviewBtn.rac_command  = self.viewModel.reviewActionCommand;
    
    // Table
    self.projectsTableView.dataSource = self.viewModel;
    self.projectsTableView.delegate   = self.viewModel;
}

- (void) updateInfo
{
    // Info
    [self.viewModel updateUserData];
    
    self.avatarImage.image  = [self.viewModel userAvatar];
    self.userNameLabel.text = [self.viewModel fullUserName];
    
    [self.projectsTableView reloadData];
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.hideMenu = ^(){
        
        [blockSelf.slidingViewController resetTopViewAnimated: YES];
        
    };
}

- (IBAction) showWelcomeTour: (UIButton*) sender
{
    [self.slidingViewController resetTopViewAnimated: YES];
    
    if ( [self.delegate respondsToSelector: @selector(showWelcomeTour)] )
        [self.delegate showWelcomeTour];
}

- (IBAction) showUserInfo: (UIButton*) sender
{
    [self.slidingViewController resetTopViewAnimated: YES];
    
    if ( [self.delegate respondsToSelector: @selector(showControllerWithSegueID:)] )
        [self.delegate showControllerWithSegueID: @"ShowUserInfoID"];
}

- (IBAction) showAllProjects: (UIButton*) sender
{
    [self.slidingViewController resetTopViewAnimated: YES];
    
    if ( [self.delegate respondsToSelector: @selector(showControllerWithSegueID:)] )
        [self.delegate showControllerWithSegueID: @"ShowAllProjects"];
}

- (IBAction) showAllTasksByProjects: (UIButton*) sender
{
    [self.slidingViewController resetTopViewAnimated: YES];
    
    if ( [self.delegate respondsToSelector: @selector(showControllerWithSegueID:)] )
    {
        [self.delegate showControllerWithSegueID: @"ShowTasks"];
        [self.delegate setSelectedTabBarItemAtIndex: 1];
    }
}

@end
