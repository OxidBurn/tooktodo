//
//  OSAlertController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertController.h"

// Classes
#import "OSAlertPlanNotLoadedController.h"
#import "OSAlertDeleteTaskWithSubtasksController.h"
#import "OSDefaultAlertController.h"
#import "OSTaskOptionsController.h"

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

+ (void) showAlertWithImage: (NSString*)                     imagePath
                   withName: (NSString*)                     name
                withMessage: (NSString*)                     message
               onController: (UIViewController*)             controller
               withDelegate: (id<OSAlertControllerProtocol>) delegate
{
    UIStoryboard* alertStoryboard = [UIStoryboard storyboardWithName: @"OSAlertStoryboard"
                                                              bundle: [NSBundle mainBundle]];
    OSAlertDesignateAdminController* alertController = [alertStoryboard instantiateViewControllerWithIdentifier: @"DesignateAdminControllerID"];

    alertController.delegate = delegate;
    
    [controller presentViewController: alertController
                             animated: YES
                           completion: nil];
    
    [alertController setImage: imagePath
                     withName: name
                  withMessage: message];

}

+ (void) showAlertWithDeleteTaskOnController: (UIViewController*) controller
{
    UIStoryboard* alertStoryboard = [UIStoryboard storyboardWithName: @"OSAlertStoryboard"
                                                              bundle: [NSBundle mainBundle]];
    
    OSAlertPlanNotLoadedController* alertController = [alertStoryboard instantiateViewControllerWithIdentifier: @"DeleteTaskWithSubtasksControllerID"];
    
    [controller presentViewController: alertController
                             animated: YES
                           completion: nil];
}

+ (void) showDefaultAlertWithTitle: (NSString*)                     title
                           message: (NSString*)                     message
                        andBtnText: (NSString*)                     btnText
                      onController: (UIViewController*)             controller
                      withDelegate: (id<OSAlertControllerProtocol>) delegate
{
    UIStoryboard* alertStoryboard = [UIStoryboard storyboardWithName: @"OSAlertStoryboard"
                                                              bundle: [NSBundle mainBundle]];
    OSDefaultAlertController* alertController = [alertStoryboard instantiateViewControllerWithIdentifier: @"DefaultAlertControllerID"];
    
    [controller presentViewController: alertController
                             animated: YES
                           completion: nil];
    
    alertController.delegate = delegate;
    
    [alertController setTitle: title
                  withMessage: message
                  withBtnText: btnText];
}


+ (void) showTaskOptionControllerOnController: (UIViewController*) controller
{
    UIStoryboard* alertStoryboard = [UIStoryboard storyboardWithName: @"OSAlertStoryboard"
                                                              bundle: [NSBundle mainBundle]];
    OSTaskOptionsController* alertController = [alertStoryboard instantiateViewControllerWithIdentifier: @"TaskOptionsControllerID"];
    
    alertController.delegate = controller;
    
    [controller presentViewController: alertController
                             animated: YES
                           completion: nil];
}

+ (void) showDeleteTaskAlertOnController: (UIViewController*) controller
                           withTaskTitle: (NSString*)         taskTitle
                            withDelegate: (id <OSAlertDeleteTasksControllerDelegate>)                delegate
{
    UIStoryboard* alertStoryboard = [UIStoryboard storyboardWithName: @"OSAlertStoryboard"
                                                              bundle: [NSBundle mainBundle]];
    
    OSAlertDeleteTasksController* alertController = [alertStoryboard instantiateViewControllerWithIdentifier: @"OSDeleteTaskAlert"];
    
    alertController.delegate = delegate;
    
    [controller presentViewController: alertController
                             animated: YES
                           completion: nil];

    [alertController setTaskTitle: taskTitle];

}
@end
