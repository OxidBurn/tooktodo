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
#import "UIViewController+Focus.h"

@interface AboutProjectViewController ()

// properties
@property (weak, nonatomic) IBOutlet UIButton* addNewRoleBtn;
@property (strong, nonatomic) AboutProjectViewModel* viewModel;

// methods

- (IBAction) selectedSegmentItemIndex: (UISegmentedControl*) sender;

@end

@implementation AboutProjectViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
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

- (void) needToUpdateContent
{
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"О ПРОЕКТЕ"
                                               withSubTitle: [self.viewModel getProjectName]];
    
    if ( [self.containerController respondsToSelector: @selector(needToUpdateContent)] )
    {
        [self.containerController needToUpdateContent];
    }
}

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}

- (IBAction) selectedSegmentItemIndex: (UISegmentedControl*) sender
{
    if ( sender.selectedSegmentIndex == 1 )
    {
        if ( [self.viewModel isAvailableAddingNewRoleToSelectedProject] )
            self.addNewRoleBtn.hidden = NO;
        
        [self showInfoScreenWithID: @"GoToRoles"];
    }
    
    else if ( sender.selectedSegmentIndex == 0 )
    {
        [self showInfoScreenWithID: @"GoToProjInformation"];
        
        self.addNewRoleBtn.hidden = YES;
    }
    
    else
    {
        [self showInfoScreenWithID: @"GoToSystemInfo"];
        
        self.addNewRoleBtn.hidden = YES;
    }
    
}

#pragma mark - Internal method -

- (void) showInfoScreenWithID: (NSString*) storyboardID
{
    [self performSegueWithIdentifier: storyboardID
                              sender: self];
}

@end
