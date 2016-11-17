//
//  BaseMainViewController+Popover.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "BaseMainViewController.h"

// Classes
#import "PopoverModel.h"

@interface BaseMainViewController (Popover) <UIPopoverPresentationControllerDelegate>

- (void) showPopoverWithDataSource: (id <PopoverModelDataSource>) dataSource
                      withDelegate: (id <PopoverModelDelegate>)   delegate
                   withSourceFrame: (CGRect)                      frame
                     withDirection: (UIPopoverArrowDirection) arrowDirection;

@end
