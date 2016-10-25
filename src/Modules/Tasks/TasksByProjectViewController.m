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

@interface TasksByProjectViewController () <UISplitViewControllerDelegate>

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
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАДАЧИ ПО ПРОЕКТАМ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
    
    // Binding UI components with model
    [self bindingUI];
    
    // Handling SplitVC
    self.splitViewController.delegate = self;
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
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.didShowTaskInfo = ^(NSString* segueId){
        
        [blockSelf performSegueWithIdentifier: @"ShowTaskDetailSegueID"
                                       sender: blockSelf];
        
    };
}

- (void) willGetFocus
{
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАДАЧИ ПО ПРОЕКТАМ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
}


#pragma mark - Actions -

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    if ( [self.delegate respondsToSelector: @selector(showMainMenu)] )
    {
        [self.delegate showMainMenu];
    }
}

#pragma mark - UISplitViewControllerDelegate methods -

- (BOOL)    splitViewController: (UISplitViewController*) splitViewController
collapseSecondaryViewController: (UIViewController*)      secondaryViewController
      ontoPrimaryViewController: (UIViewController*)      primaryViewController
{
    return NO;
}

- (BOOL)splitViewController:(UISplitViewController *)splitViewController showDetailViewController:(UIViewController *)vc sender:(id)sender
{
    return NO;
}

@end
