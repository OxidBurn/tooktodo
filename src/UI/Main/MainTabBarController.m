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

#import "KeyChainManager.h"

@implementation MainTabBarController

#pragma mark - Life cycle -

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
            [self presentWelcomeTour];
        }
}

#pragma mark - Internal methods -

- (BOOL) shouldShowLogin
{
//    return ![KeyChain isExistTokenForCurrentUser];
    
    return NO;
}

- (BOOL) isFirstSetup
{
//    return ([UserDefaults boolForKey: @"isViewedWelcomeTour"] == NO);
    return NO;
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
    
    // Handle dismiss action
    __weak typeof(self) blockSelf = self;
    
    loginViewController.dismissLoginView = ^(){
        
        if ( [blockSelf isFirstSetup] )
        {
            [blockSelf presentWelcomeTour];
        }
        
    };
}

- (void) presentWelcomeTour
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

@end
