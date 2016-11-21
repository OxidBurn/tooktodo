//
//  OSAlertDeleteTast.h
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertViewController.h"

@protocol OSAlertDeleteTaskWithSubtasksControllerDelegate;

@interface OSAlertDeleteTaskWithSubtasksController : OSAlertViewController

@end

@protocol OSAlertDeleteTaskWithSubtasksControllerDelegate <NSObject>

- (void) performActionAtIndexPath: (NSIndexPath*) indexPath;

@end
