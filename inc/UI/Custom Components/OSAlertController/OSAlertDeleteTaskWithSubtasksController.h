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

@property (weak, nonatomic) id<OSAlertDeleteTaskWithSubtasksControllerDelegate> delegate;

@end

@protocol OSAlertDeleteTaskWithSubtasksControllerDelegate <NSObject>

- (void) performActionAtIndexPath: (NSIndexPath*) indexPath;

- (void) deleteTaskWithSubtasks: (BOOL) subtasks;

@end
