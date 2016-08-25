//
//  DocumentsViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DocumentsViewController.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"

@implementation DocumentsViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ДОКУМЕНТЫ"
                                               withSubTitle: @"Квартира на Ходынке"];
}

@end
