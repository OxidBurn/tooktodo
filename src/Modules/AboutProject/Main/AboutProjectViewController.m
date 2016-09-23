//
//  AboutProjectViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AboutProjectViewController.h"

// Classes
#import "MainTabBarController.h"
#import "ProjectsControllersDelegate.h"
#import "AboutProjectViewModel.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"

@interface AboutProjectViewController ()

// properties

@property (weak, nonatomic) id <ProjectsControllersDelegate> delegate;

@property (strong, nonatomic) AboutProjectViewModel* viewModel;

// methods

- (IBAction) selectedSegmentItemIndex: (UISegmentedControl*) sender;


@end

@implementation AboutProjectViewController

#pragma mark - Life cycle -

- (void)loadView
{
    [super loadView];
    
    // setup delegate
    self.delegate = (MainTabBarController*)self.navigationController.parentViewController;
    
    // Setup navigation
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"О ПРОЕКТЕ"
                                               withSubTitle: [self.viewModel getProjectName]];
    
    [self showInfoScreenWithID: @"GoToProjInformation"];
    
}


#pragma mark - Memory managment -


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (AboutProjectViewModel *)viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [AboutProjectViewModel new];
    }
    
    return _viewModel;
}

#pragma mark - Action -

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}

- (IBAction) selectedSegmentItemIndex: (UISegmentedControl*) sender
{
    if ( sender.selectedSegmentIndex == 1 )
    {
        [self showInfoScreenWithID: @"GoToRoles"];
    }
    
    else if ( sender.selectedSegmentIndex == 0 )
    {
        [self showInfoScreenWithID: @"GoToProjInformation"];
    }
    
    else
    {
        [self showInfoScreenWithID: @"GoToSystemInfo"];
    }
    
}

#pragma mark - Internal method -

- (void) showInfoScreenWithID: (NSString*) storyboardID
{
    [self performSegueWithIdentifier: storyboardID
                              sender: self];
}

@end
