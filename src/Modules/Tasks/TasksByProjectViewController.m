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
#import "AllTasksViewModel.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"
#import "DataManager+ProjectInfo.h"

@interface TasksByProjectViewController ()

// Properties
@property (weak, nonatomic) id<ProjectsControllersDelegate> delegate;

@property (weak, nonatomic) IBOutlet UITableView* tasksByProjectTableView;

@property (strong, nonatomic) AllTasksViewModel* viewModel;

// Methods

- (void) bindingUI;

@end

@implementation TasksByProjectViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup main navigation delegate
    self.delegate = (MainTabBarController*)self.navigationController.parentViewController;
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАДАЧИ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
    
    // Binding UI components with model
    [self bindingUI];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    @weakify(self)
    
    [[self.viewModel updateContent]
     subscribeCompleted: ^{
     
         @strongify(self)
         
         [self.tasksByProjectTableView reloadData];
         
    }];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


#pragma mark - Properties -

- (AllTasksViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [[AllTasksViewModel alloc] init];
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    self.tasksByProjectTableView.dataSource = self.viewModel;
    self.tasksByProjectTableView.delegate   = self.viewModel;
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
