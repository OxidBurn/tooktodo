//
//  MainMenuViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/15/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "MainMenuViewController.h"

// Frameworks
#import <ReactiveCocoa.h>

// Classes
#import "MainMenuViewModel.h"
#import "MainTabBarController.h"

@interface MainMenuViewController ()

// properties

@property (weak, nonatomic) IBOutlet UIImageView *avatarImage;
@property (weak, nonatomic) IBOutlet UILabel     *userNameLabel;
@property (weak, nonatomic) IBOutlet UITableView *projectsTableView;
@property (weak, nonatomic) IBOutlet UIButton    *showHelpBtn;
@property (weak, nonatomic) IBOutlet UIButton    *supportBtn;
@property (weak, nonatomic) IBOutlet UIButton    *reviewBtn;

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
    
    // Binding all UI with model
    [self bindingUI];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    // Update info of the user
    [self updateInfo];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation -

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    
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
    self.avatarImage.image  = [self.viewModel userAvatar];
    self.userNameLabel.text = [self.viewModel fullUserName];
}

- (IBAction) showWelcomeTour: (UIButton*) sender
{
    [self.slidingViewController resetTopViewAnimated: YES];
    
    MainTabBarController* topController = (MainTabBarController*)self.slidingViewController.topViewController;
    
    [topController presentWelcomeTour];
}


@end
