//
//  OSAlertDeleteTasksController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 18.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertViewController.h"

@protocol OSAlertDeleteTasksControllerDelegate;

@interface OSAlertDeleteTasksController : OSAlertViewController

@property (weak, nonatomic) id <OSAlertDeleteTasksControllerDelegate> delegate;

- (void) setTaskTitle: (NSString*) title;

@end

@protocol OSAlertDeleteTasksControllerDelegate <NSObject>

- (void) didDeleteTask;

@end
