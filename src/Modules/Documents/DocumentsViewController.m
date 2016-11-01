//
//  DocumentsViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DocumentsViewController.h"

// Classes
#import "ProjectsControllersDelegate.h"
#import "MainTabBarController.h"
#import "Macroses.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"
#import "DataManager+ProjectInfo.h"

@interface DocumentsViewController()

// properties
@property (weak, nonatomic) id<ProjectsControllersDelegate> delegate;

// methods


@end

@implementation DocumentsViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Main navigation delegate
    self.delegate = (MainTabBarController*)self.navigationController.parentViewController;
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ДОКУМЕНТЫ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
    
    // Handing 'Menu' button according to device
    if ( IS_PHONE == NO )
        self.navigationItem.leftBarButtonItem = nil;
}


#pragma mark - Actions -

- (void) willGetFocus
{
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ДОКУМЕНТЫ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
}

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    if ( [self.delegate respondsToSelector: @selector(showMainMenu)] )
    {
        [self.delegate showMainMenu];
    }
}

@end
