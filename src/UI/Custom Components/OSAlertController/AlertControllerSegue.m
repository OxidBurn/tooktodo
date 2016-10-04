//
//  AlertControllerSegue.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AlertControllerSegue.h"

@implementation AlertControllerSegue

#pragma mark - Segue methods -

- (void) perform
{
    UIViewController* sourceController      = self.sourceViewController;
    UIViewController* destinationController = self.destinationViewController;
    
    [self addChildController: destinationController
                    toParent: sourceController];
    
    [self addChildView: destinationController.view
          toParentView: sourceController.view];
}


#pragma mark - Internal methods -

- (void) addChildController: (UIViewController*) child
                   toParent: (UIViewController*) parent
{
    [parent addChildViewController: child];
    
    [child didMoveToParentViewController: parent];
}

- (void) addChildView: (UIView*) child
         toParentView: (UIView*) parent
{
    child.frame                                      = parent.frame;
    child.translatesAutoresizingMaskIntoConstraints  = NO;
    
    [parent addSubview: child];
    
    NSLayoutConstraint* xPositionConstraint = [NSLayoutConstraint constraintWithItem: child
                                                                           attribute: NSLayoutAttributeLeft
                                                                           relatedBy: NSLayoutRelationEqual
                                                                              toItem: parent
                                                                           attribute: NSLayoutAttributeLeft
                                                                          multiplier: 1.0f
                                                                            constant: 0.0f];
    NSLayoutConstraint* yPositionConstraint = [NSLayoutConstraint constraintWithItem: child
                                                                           attribute: NSLayoutAttributeTop
                                                                           relatedBy: NSLayoutRelationEqual
                                                                              toItem: parent
                                                                           attribute: NSLayoutAttributeTop
                                                                          multiplier: 1.0f
                                                                            constant: 0.0f];
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
                              xPositionConstraint,
                              yPositionConstraint]];
}


@end
