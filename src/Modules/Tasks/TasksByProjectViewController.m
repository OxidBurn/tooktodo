//
//  TasksByProjectViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TasksByProjectViewController.h"

// Classes
#import "ProjectsControllersDelegate.h"
#import "MainTabBarController.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"

@interface TasksByProjectViewController ()

// Properties
@property (weak, nonatomic) id<ProjectsControllersDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView* tasksByProjectTableView;

// Methods

@end

@implementation TasksByProjectViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup main navigation delegate
    self.delegate = (MainTabBarController*)self.navigationController.parentViewController;
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"Задачи"
                                               withSubTitle: @"Квартира на Ходынке"];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
