//
//  OSAlertController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "OSDefaultAlertController.h"
#import "OSAlertDesignateAdminController.h"
#import "OSAlertControllerProtocol.h"
#import "OSAlertDeleteTasksController.h"

@interface OSAlertController : NSObject

+ (void) showAlertWithPlanTableOnController: (UIViewController*) controller;

+ (void) showAlertWithImage: (NSString*)                     imagePath
                   withName: (NSString*)                     name
                withMessage: (NSString*)                     message
               onController: (UIViewController*)             controller
               withDelegate: (id<OSAlertControllerProtocol>) delegate;

+ (void) showAlertWithDeleteTaskOnController: (UIViewController*) controller;

+ (void) showDefaultAlertWithTitle: (NSString*)                     title
                           message: (NSString*)                     message
                        andBtnText: (NSString*)                     btnText
                      onController: (UIViewController*)             controller
                      withDelegate: (id<OSAlertControllerProtocol>) delegate;

+ (void) showTaskOptionControllerOnController: (UIViewController*) controller;

+ (void) showDeleteTaskAlertOnController: (UIViewController*) controller
                           withTaskTitle: (NSString*)         taskTitle
                            withDelegate: (id <OSAlertDeleteTasksControllerDelegate>)                delegate;

@end
