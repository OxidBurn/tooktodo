//
//  TasksViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksViewController.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"
#import "DataManager+ProjectInfo.h"

@implementation TasksViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАДАЧИ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
}

- (void) willGetFocus
{
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАДАЧИ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
}

@end
