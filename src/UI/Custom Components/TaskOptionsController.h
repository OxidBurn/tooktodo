//
//  TaskOptionsController.h
//  TookTODO
//
//  Created by Lera on 12.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertViewController.h"

@protocol TaskOptionsControllerDelegate;

@interface TaskOptionsController : OSAlertViewController

@property (nonatomic, weak) id<TaskOptionsControllerDelegate> delegate;

@end

@protocol TaskOptionsControllerDelegate <NSObject>

- (void) showAnotherScreen;

@end