//
//  ProfileViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProfileViewController.h"
#import "ProjectsControllersDelegate.h"
#import "MainTabBarController.h"

@interface ProfileViewController ()

// properties

@property (weak, nonatomic) id <ProjectsControllersDelegate> delegate;

// methods

- (IBAction) selectedSegmentItemIndex: (UISegmentedControl*) sender;

@end

@implementation ProfileViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // setup delegate
    self.delegate = (MainTabBarController*)self.navigationController.parentViewController;
    
    [self showInfoScreenWithID: @"UserDetailScreen"];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions -

- (IBAction) selectedSegmentItemIndex: (UISegmentedControl*) sender
{
    if ( sender.selectedSegmentIndex == 0 )
    {
        [self showInfoScreenWithID: @"UserDetailScreen"];
    }
    else
    {
        [self showInfoScreenWithID: @"UserNotificationsScreen"];
    }
}

- (IBAction) showMainMenu: (UIBarButtonItem*) sender
{
    if ( [self.delegate respondsToSelector: @selector(showMainMenu)] )
    {
        [self.delegate showMainMenu];
    }
}


#pragma mark - Internal methods -

- (void) showInfoScreenWithID: (NSString*) storyboardID
{
    [self performSegueWithIdentifier: storyboardID
                              sender: self];
}

@end
