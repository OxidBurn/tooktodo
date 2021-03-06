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

@interface MainTabBarController()  <OSTaskOptionsControllerDelegate, CustomTabBarDelegate, CustomTabBarIPadDelegate>

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
    self.mainTabBariPad.taskDelegateIPad = self;
    
    [DefaultNotifyCenter addObserver: self
                            selector: @selector(showLogin)
                                name: @"ShowLoginScreen"
                              object: nil];
    
    [DefaultNotifyCenter addObserver: self
                            selector: @selector(showTaskScreen)
                                name: @"ShowTaskScreen"
                              object: nil];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    if ( [self isFirstSetup] )
    {
        [self showWelcomeTour];
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
    
    [DefaultNotifyCenter removeObserver: self
                                   name: @"ShowTaskScreen"
                                 object: nil];
}

#pragma mark - Properties -


#pragma mark - Internal methods -

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
    
    [self presentViewController: loginViewController
                       animated: YES
                     completion: nil];
}


#pragma mark - Projects main controllers delegates -

- (void) showMainMenu
{
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}

- (void) hideMainMenu
{
    [self.slidingViewController resetTopViewAnimated: YES
                                          onComplete: ^{
        
                                              
    }];
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
    {
        [controller.visibleViewController needToUpdateContent];
    }
    else
        if ( [controller respondsToSelector: @selector(needToUpdateContent)] )
        {
            [controller needToUpdateContent];
        }

}

- (void) showTaskScreen
{
    [self showControllerWithSegueID: @"ShowTasks"];
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


#pragma mark - CustomTabBarIPad delegate methods -

- (void) showTaskOptionsIPad
{
    [OSAlertController showTaskOptionControllerOnController: self];
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
