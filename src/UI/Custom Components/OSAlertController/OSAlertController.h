//
//  OSAlertController.h
//  TookTODO
//
//  Created by Lera on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "OSDefaultAlertController.h"

@interface OSAlertController : NSObject

+ (void) showAlertWithPlanTableOnController: (UIViewController*) controller;

+ (void) showAlertWithImage: (UIImage*)  image
                   withName: (NSString*) name
                withMessage: (NSString*) message
               onController: (UIViewController*) controller;

+ (void) showAlertWithDeleteTaskOnController: (UIViewController*) controller;

+ (void) showDefaultAlertWithTitle: (NSString*)         title
                           message: (NSString*)         message
                        andBtnText: (NSString*)         btnText
                      onController: (UIViewController*) controller
                      withDelegate: (id<OSDefaultAlertControllerDelegate>) delegate;

+ (void) showTaskOptionControllerOnController: (UIViewController*) controller;

@end
