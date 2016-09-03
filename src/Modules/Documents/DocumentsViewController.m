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

// Categories
#import "BaseMainViewController+NavigationTitle.h"

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
                                               withSubTitle: @"Квартира на Ходынке"];
}


#pragma mark - Actions -

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    if ( [self.delegate respondsToSelector: @selector(showMainMenu)] )
    {
        [self.delegate showMainMenu];
    }
}

@end
