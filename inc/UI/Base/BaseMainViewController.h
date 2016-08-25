//
//  BaseMainViewController.h
//  Test
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks

#import <UIKit/UIKit.h>
#import "ECSlidingViewController.h"
#import "UIViewController+ECSlidingViewController.h"
#import "PopoverModel.h"

@interface BaseMainViewController : UIViewController <UIViewControllerAnimatedTransitioning, ECSlidingViewControllerDelegate, ECSlidingViewControllerLayout>

// properties


// methods

- (void) showPopoverWithType: (NSUInteger)                type
                withDelegate: (id <PopoverModelDelegate>) delegate
             withSourceFrame: (CGRect)                    frame;


@end
