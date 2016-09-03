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

@interface BaseMainViewController : UIViewController <UIViewControllerAnimatedTransitioning, ECSlidingViewControllerDelegate, ECSlidingViewControllerLayout>

@end
