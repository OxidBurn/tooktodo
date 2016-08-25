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
{
    PopoverModel* model = [[PopoverModel alloc] initWithDataSource: dataSource
                                                      withDelegate: delegate];
    
    PopoverViewController* controller = [self.storyboard instantiateViewControllerWithIdentifier: @"SortProjectsControllerID"];
    
    controller.modalPresentationStyle = UIModalPresentationPopover;
    
    [controller setPopoverModel: model];
    
    UIPopoverPresentationController* popover = controller.popoverPresentationController;
    
    popover.sourceRect               = frame;
    popover.sourceView               = self.view;
    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    
    popover.delegate = self;
    
    [self presentViewController: controller
                       animated: YES
                     completion: nil];
}

#pragma mark - UIPopoverPresentationControllerDelegate methods -

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController*) controller
{
    return UIModalPresentationNone;
}

@end
