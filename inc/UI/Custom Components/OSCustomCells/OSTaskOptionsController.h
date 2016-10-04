//
//  TaskOptionsController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 12.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertViewController.h"

@protocol OSTaskOptionsControllerDelegate;

@interface OSTaskOptionsController : OSAlertViewController

@property (nonatomic, weak) id<OSTaskOptionsControllerDelegate> delegate;

@end

@protocol OSTaskOptionsControllerDelegate <NSObject>

- (void) showAnotherScreen;

@end
