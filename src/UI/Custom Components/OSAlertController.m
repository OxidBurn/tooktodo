//
//  OSAlertController.m
//  TookTODO
//
//  Created by Lera on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertController.h"
#import "OSAlertDesignateAdminController.h"

@implementation OSAlertController

+ (void) showAlertWithPlanTableOnController: (UIViewController*) controller
{
    
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
                     withName: name];}

+ (void) showAlertWithDeleteTaskOnController: (UIViewController*) controller
{
    
}

@end
