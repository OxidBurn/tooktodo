//
//  TabBarSegue.m
//  TestTabBar
//
//  Created by Nikolay Chaban on 17.08.16.
//  Copyright © 2016 GlebCherkashyn. All rights reserved.
//

#import "TabBarSegue.h"
#import "MainTabBarController.h"

@implementation TabBarSegue

- (void) perform
{
    MainTabBarController* sourceController = (MainTabBarController*)self.sourceViewController;
    UIViewController* destinationController                   = self.destinationViewController;
    
    if ( sourceController.containerController )
    {
        [self removeChildViewControllerFromParent: sourceController];
    }
    
    
    [self addChildController: destinationController
                    toParent: sourceController];
    
    [self addChildView: destinationController.view
          toParentView: sourceController.containerView];
}

- (void) addChildController: (UIViewController*)     child
                   toParent: (MainTabBarController*) parent
{
    [parent addChildViewController: child];
    
    [child didMoveToParentViewController: parent];
    
    parent.containerController = child;
}

- (void) addChildView: (UIView*) child
         toParentView: (UIView*) parent
{
    child.frame                                      = parent.frame;
    child.translatesAutoresizingMaskIntoConstraints  = NO;
    
    [parent addSubview: child];
    
    NSLayoutConstraint* heightConstraint = [NSLayoutConstraint constraintWithItem: child
                                                                        attribute: NSLayoutAttributeHeight
                                                                        relatedBy: NSLayoutRelationEqual
                                                                           toItem: parent
                                                                        attribute: NSLayoutAttributeHeight
                                                                       multiplier: 1
                                                                         constant: 0];
    NSLayoutConstraint* widthConstraint = [NSLayoutConstraint constraintWithItem: child
                                                                       attribute: NSLayoutAttributeWidth
                                                                       relatedBy: NSLayoutRelationEqual
                                                                          toItem: parent
                                                                       attribute: NSLayoutAttributeWidth
                                                                      multiplier: 1
                                                                        constant: 0];
    
    [parent addConstraints: @[heightConstraint,
                              widthConstraint]];
}

- (void) removeChildViewControllerFromParent: (MainTabBarController*) parent
{
    [parent.containerController willMoveToParentViewController: nil];
    
    [parent.containerView.subviews enumerateObjectsUsingBlock: ^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj removeFromSuperview];
        
    }];
    
    [parent.containerView.constraints enumerateObjectsUsingBlock: ^(__kindof NSLayoutConstraint * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [parent.containerView removeConstraint: obj];
        
    }];
    
    [parent.containerController removeFromParentViewController];
}

@end
