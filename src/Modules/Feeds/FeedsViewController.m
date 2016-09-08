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

@property (weak, nonatomic) id<ProjectsControllersDelegate> delegate;

@end

@implementation FeedsViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup navigation title view
     [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЛЕНТА"
                                                withSubTitle: [DataManagerShared getSelectedProjectName]];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.delegate = (MainTabBarController*)self.navigationController.parentViewController;
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    if ( [self.delegate respondsToSelector: @selector(showMainMenu)] )
    {
        [self.delegate showMainMenu];
    }
}

@end
