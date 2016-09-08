//
//  OSAlertController.m
//  TookTODO
//
//  Created by Lera on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertController.h"
#import "OSAlertDesignateAdminController.h"
#import "OSAlertPlanNotLoadedController.h"
#import "OSAlertDeleteTaskController.h"

@implementation OSAlertController

+ (void) showAlertWithPlanTableOnController: (UIViewController*) controller
{
    UIStoryboard* alertStoryboard = [UIStoryboard storyboardWithName: @"OSAlertStoryboard"
                                                              bundle: [NSBundle mainBundle]];
    OSAlertPlanNotLoadedController* alertController = [alertStoryboard instantiateViewControllerWithIdentifier: @"PlanNotLoadedControllerID"];
    
    [controller presentViewController: alertController
                             animated: YES
                           completion: nil];
}

+ (void) showAlertWithImage: (UIImage*)  image
                   withName: (NSString*) name
               onController: (UIViewController*) controller
{
    UIStoryboard* alertStoryboard = [UIStoryboard storyboardWithName: @"OSAlertStoryboard"
                                                              bundle: [NSBundle mainBundle]];
    OSAlertDesignateAdminController* alertController = [alertStoryboard instantiateViewControllerWithIdentifier: @"DesignateAdminControllerID"];
    
    [controller presentViewController: alertController
                             animated: YES
                           completion: nil];
    
    [alertController setImage: image
                     withName: name];
}

+ (void) showAlertWithDeleteTaskOnController: (UIViewController*) controller
{
    UIStoryboard* alertStoryboard = [UIStoryboard storyboardWithName: @"OSAlertStoryboard"
                                                              bundle: [NSBundle mainBundle]];
    OSAlertPlanNotLoadedController* alertController = [alertStoryboard instantiateViewControllerWithIdentifier: @"DeleteTaskControllerID"];
    
    [controller presentViewController: alertController
                             animated: YES
                           completion: nil];
}

@end
