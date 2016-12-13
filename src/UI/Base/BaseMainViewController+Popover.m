//
//  BaseMainViewController+Popover.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController+Popover.h"
#import "PopoverViewController.h"

@implementation BaseMainViewController (Popover) 

#pragma mark - Popover -

- (void) showPopoverWithDataSource: (id <PopoverModelDataSource>) dataSource
                      withDelegate: (id <PopoverModelDelegate>)   delegate
                   withSourceFrame: (CGRect)                      frame
                     withDirection: (UIPopoverArrowDirection)     arrowDirection

{
    PopoverModel* model = [[PopoverModel alloc] initWithDataSource: dataSource
                                                      withDelegate: delegate];
    
    PopoverViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier: @"SortProjectsControllerID"];
    
    [controller setPopoverModel: model];
    
    [controller setupControllerWithDelegate: self
                                  withFrame: frame
                              withDirection: arrowDirection];
}

#pragma mark - UIPopoverPresentationControllerDelegate methods -

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController*) controller
{
    return UIModalPresentationNone;
}

@end
