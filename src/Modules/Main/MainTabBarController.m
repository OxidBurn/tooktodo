//
//  MainTabBarController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/12/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "MainTabBarController.h"
#import "LoginViewController.h"
#import "WelcomeTourViewController.h"
#import "CustomTabBar.h"

#import "KeyChainManager.h"

@interface MainTabBarController() 

@property (weak, nonatomic) IBOutlet CustomTabBar *mainTabBar;


@end

@implementation MainTabBarController 

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    self.mainTabBar.delegate = self;
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
}

- (void) viewDidAppear: (BOOL) animated
{
    [super viewDidAppear: animated];
    
    if ( [self shouldShowLogin] )
    {
        [self presentLoginController];
    }
    else
        if ( [self isFirstSetup] )
        {
            [self showWelcomeTour];
        }
}

#pragma mark - Internal methods -

- (BOOL) shouldShowLogin
{
    return ![KeyChain isExistTokenForCurrentUser];
}

- (BOOL) isFirstSetup
{
    return ([UserDefaults boolForKey: @"isViewedWelcomeTour"] == NO);
}

- (void) presentLoginController
{
    NSString* controllerId   = @"LoginScreenID";
    NSString* storyboardName = @"LoginScreen";
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName: storyboardName
                                                         bundle: nil];
    
    LoginViewController* loginViewController = [storyboard instantiateViewControllerWithIdentifier: controllerId];
    
    // always assumes token is valid - should probably check in a real app
    [self presentViewController: loginViewController
                       animated: NO
                     completion: nil];
}


#pragma mark - Projects main controllers delegates -

- (void) showMainMenu
{
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}

- (void) dismissTopController: (UIViewController*) controller
{
    [controller dismissViewControllerAnimated: YES
                                   completion: nil];
}

- (void) showLogin
{
    [self presentLoginController];
    
    [self showControllerWithSegueID: @"ShowFeeds"];
}

- (void) showWelcomeTour
{
    NSString* controllerId   = @"WelcomeScreenID";
    NSString* storyboardName = @"WelcomeTour";
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName: storyboardName
                                                         bundle: nil];
    
    WelcomeTourViewController* welcomeTourController = [storyboard instantiateViewControllerWithIdentifier: controllerId];
    
    // always assumes token is valid - should probably check in a real app
    [self presentViewController: welcomeTourController
                       animated: NO
                     completion: nil];
}

- (void) showControllerWithSegueID: (NSString*) segueID
{
    [self performSegueWithIdentifier: segueID
                              sender: self];
}


@end