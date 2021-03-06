//
//  PopoverViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 23.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

// Classes
#import "PopoverModel.h"

@interface PopoverViewController : UIViewController

- (void) setPopoverModel: (PopoverModel*) model;

- (void) setupControllerWithDelegate: (id)                      delegate
                           withFrame: (CGRect)                  frame
                       withDirection: (UIPopoverArrowDirection) arrowDirection;

@end
