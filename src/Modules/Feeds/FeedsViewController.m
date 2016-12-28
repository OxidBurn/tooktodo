//
//  FeedsViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 17.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FeedsViewController.h"
#import "MainTabBarController.h"
#import "ProjectsControllersDelegate.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"
#import "DataManager+ProjectInfo.h"

@interface FeedsViewController ()

@end

@implementation FeedsViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup navigation title view
     [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЛЕНТА"
                                                withSubTitle: @""];
    
    // Add updating notification
    [DefaultNotifyCenter addObserver: self
                            selector: @selector(needToUpdateContent)
                                name: @"NeedToUpdateContent"
                              object: nil];
    
    
    [self needToUpdateContent];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) dealloc
{
    [DefaultNotifyCenter removeObserver: self
                                   name: @"NeedToUpdateContent"
                                 object: nil];
}


#pragma mark - Action -

- (void) needToUpdateContent
{
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЛЕНТА"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
}

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}

@end
