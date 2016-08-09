//
//  AppDelegate+RootController.m
//  TookTODO
//
//  Created by Глеб on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AppDelegate+RootController.h"
#import "APIConstance.h"

@implementation AppDelegate (RootController)

- (void) setupRootController
{
    // Override point for customization after application launch.
    NSString* token = [[NSUserDefaults standardUserDefaults] valueForKey: accessToken];
    
    NSString* controllerId   = (token) ? @"ListControllerID" : @"LoginScreenID";
    NSString* storyboardName = (token) ? @"Main" : @"LoginStoryboard";
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName: storyboardName
                                                         bundle: nil];
    
    UIViewController* initViewController = [storyboard instantiateViewControllerWithIdentifier: controllerId];
    
    // always assumes token is valid - should probably check in a real app
    if (token)
    {
        [self.window setRootViewController: initViewController];
    }
    else
    {
        [(UINavigationController*)self.window.rootViewController pushViewController: initViewController
                                                                           animated: NO];
    }
}

@end
