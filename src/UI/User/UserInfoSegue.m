//
//  UserInfoSegue.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserInfoSegue.h"
#import "ProfileViewController.h"

@implementation UserInfoSegue

- (void) perform
{
    ProfileViewController* sourceController = (ProfileViewController*)self.sourceViewController;
    UIViewController* destinationController = self.destinationViewController;
    
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
                   toParent: (ProfileViewController*) parent
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
    
    NSLayoutConstraint* topPositionConstraint = [NSLayoutConstraint constraintWithItem: child
                                                                             attribute: NSLayoutAttributeTop
                                                                             relatedBy: NSLayoutRelationEqual
                                                                                toItem: parent
                                                                             attribute: NSLayoutAttributeTop
                                                                            multiplier: 1.0
                                                                              constant: 0];
    
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
                              widthConstraint,
                              topPositionConstraint]];
}

- (void) removeChildViewControllerFromParent: (ProfileViewController*) parent
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
