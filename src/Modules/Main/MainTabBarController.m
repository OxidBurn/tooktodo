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
#import "MainTabBar.h"
#import "OSAlertController.h"
#import "OSTaskOptionsController.h"
#import "AddTaskViewController.h"
#import "CustomTabBar.h"
#import "CustomTabBarIPad.h"

#import "KeyChainManager.h"

@interface MainTabBarController()  <OSTaskOptionsControllerDelegate, CustomTabBarDelegate>

@property (weak, nonatomic) IBOutlet CustomTabBar*     mainTabBariPhone;
@property (weak, nonatomic) IBOutlet CustomTabBarIPad* mainTabBariPad;

@property (assign, nonatomic) BOOL isCheckedLogin;

@end

@implementation MainTabBarController 


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    self.mainTabBariPhone.delegate     = self;
    self.mainTabBariPad.delegate       = self;
    self.mainTabBariPhone.taskDelegate = self;
    
    [DefaultNotifyCenter addObserver: self
                            selector: @selector(showLogin)
                                name: @"ShowLoginScreen"
                              object: nil];
    
    

}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    // Hack for showing login screen before will load feed screen
    // If will find any better solution, please remove this chunk of code
    if ( self.isCheckedLogin == NO )
    {
        if ( [self shouldShowLogin] )
        {
            [self presentLoginController];
        }
        else
            if ( [self isFirstSetup] )
            {
                [self showWelcomeTour];
            }
        
        self.isCheckedLogin = YES;
    }
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) dealloc
{
    [DefaultNotifyCenter removeObserver: self
                                   name: @"ShowLoginScreen"
                                 object: nil];
}

#pragma mark - Properties -


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

- (void) hideMainMenu
{
    [self.slidingViewController resetTopViewAnimated: YES];
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

- (void) willGetFocus
{
    UINavigationController* controller = (UINavigationController*)self.containerController;
    
    if ( [controller.visibleViewController respondsToSelector: @selector(willGetFocus)] )
        [controller.visibleViewController willGetFocus];
}

- (void) needToUpdateContent
{
    UINavigationController* controller = (UINavigationController*)self.containerController;
    
    if ( [controller isKindOfClass: [UINavigationController class]] && [controller.visibleViewController respondsToSelector: @selector(needToUpdateContent)] )
        [controller.visibleViewController needToUpdateContent];

}

#pragma mark - CustomTabBarDelegate methods -

- (void) showTaskOptions
{
    [OSAlertController showTaskOptionControllerOnController: self];
}

- (void) showFeedsForSelectedProject
{
    [self showControllerWithSegueID: @"ShowFeeds"];
}

- (void) setSelectedTabBarItemAtIndex: (NSUInteger) index
{
    [self.mainTabBariPhone setSelectedItemAtIndex: index];
    [self.mainTabBariPad setSelectedItemAtIndex: index];
}


#pragma mark - TaskOptionsControllerDelegate -

- (void) onShowAddNewTaskScreen
{
    UIStoryboard* alertStoryboard = [UIStoryboard storyboardWithName: @"TaskOptionsScreen"
                                                              bundle: [NSBundle mainBundle]];
    
    AddTaskViewController* addTaskController = [alertStoryboard instantiateViewControllerWithIdentifier: @"AddTaskNavControllerID"];
    
    [self presentViewController: addTaskController
                       animated: YES
                     completion: nil];
}
@end
