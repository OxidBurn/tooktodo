//
//  AppDelegate.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/8/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AppDelegate.h"
#import <Fabric/Fabric.h>
#import <Crashlytics/Crashlytics.h>
#import <MagicalRecord/MagicalRecord.h>
#import "LoginViewController.h"
#import "MainTabBarController.h"
#import "KeyChainManager.h"


@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)           application: (UIApplication*) application
 didFinishLaunchingWithOptions: (NSDictionary*)  launchOptions
{
    [Fabric with: @[[Crashlytics class]]];
    [SVProgressHUD setDefaultMaskType: SVProgressHUDMaskTypeClear];
    
    if ( [self shouldShowLogin] )
    {
        [self presentLoginController];
    }
    
    return YES;
}

- (void) applicationWillResignActive: (UIApplication*) application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void) applicationDidEnterBackground: (UIApplication*) application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
//    [MagicalRecord cleanUp];
}

- (void) applicationWillEnterForeground: (UIApplication*) application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void) applicationDidBecomeActive: (UIApplication*) application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void) applicationWillTerminate: (UIApplication*) application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

// Asks the delegate for the interface orientations to use for the view controllers in the specified window.

- (UIInterfaceOrientationMask) application: (UIApplication*) application
   supportedInterfaceOrientationsForWindow: (UIWindow*)      window
{
    if ( IS_PHONE )
    {
        return UIInterfaceOrientationMaskPortrait;
    }
    else
    {
        return UIInterfaceOrientationMaskLandscape;
    }
}


#pragma mark - Internal methods -

- (BOOL) shouldShowLogin
{
    return ![KeyChain isExistTokenForCurrentUser];
}

- (void) presentLoginController
{
    NSString* controllerId   = @"LoginScreenID";
    NSString* storyboardName = @"LoginScreen";
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName: storyboardName
                                                         bundle: nil];
    
    LoginViewController* loginViewController = [storyboard instantiateViewControllerWithIdentifier: controllerId];
    
    self.window.rootViewController = loginViewController;
    
    __weak typeof(self) blockSelf = self;
    
    loginViewController.dismissLoginView = ^(){
        
        blockSelf.window.rootViewController = [[UIStoryboard storyboardWithName: @"MainScreen"
                                                                         bundle: MainBundle] instantiateInitialViewController];
        
    };
}

@end
