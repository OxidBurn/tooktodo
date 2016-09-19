//
//  OSAlertDeleteTast.h
//  TookTODO
//
//  Created by Lera on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertViewController.h"

@protocol OSAlertDeleteTaskControllerDelegate;

@interface OSAlertDeleteTaskController : OSAlertViewController

@end

@protocol OSAlertDeleteTaskControllerDelegate <NSObject>

- (void) performActionAtIndexPath: (NSIndexPath*) indexPath;

@end