//
//  OSAlertController.h
//  TookTODO
//
//  Created by Lera on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OSAlertController : NSObject

+ (void) showAlertWithPlanTableOnController: (UIViewController*) controller;

+ (void) showAlertWithImage: (UIImage*)  image
                   withName: (NSString*) name
               onController: (UIViewController*) controller;

+ (void) showAlertWithDeleteTaskOnController: (UIViewController*) controller;

@end
