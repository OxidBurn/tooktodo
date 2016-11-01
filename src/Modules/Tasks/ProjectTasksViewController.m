//
//  ProjectTasksViewController.m
//  TookTODO
//
// Created by Nikolay Chaban on 28.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProjectTasksViewController.h"

//Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "ProjectsControllersDelegate.h"
#import "MainTabBarController.h"
#import "ProjectTasksViewModel.h"
#import "PopoverViewController.h"
#import "TaskDetailViewController.h"
#import "ProjectTask+CoreDataClass.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"
#import "DataManager+ProjectInfo.h"
#import "BaseMainViewController+Popover.h"

@interface ProjectTasksViewController () <UISplitViewControllerDelegate>

// Properties

@property (weak, nonatomic) id<ProjectsControllersDelegate> delegate;

@property (nonatomic, strong) ProjectTasksViewModel* viewModel;

@property (strong, nonatomic) TaskDetailViewController* taskDetailVC;

// Outlets

@property (weak, nonatomic) IBOutlet UITableView* tasksByProjectTableView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem* onSortTasks;

// Methods

- (void) bindingUI;

// Actions

- (IBAction) onSortTasks:(UIBarButtonItem*) sender;


@end

@implementation ProjectTasksViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup main navigation delegate
    self.delegate = (MainTabBarController*)self.navigationController.parentViewController;
    
    // Binding UI components with model
    [self bindingUI];
    
    if (IS_PHONE == NO)
    {
        self.navigationItem.leftBarButtonItem = nil;
    }

    
    // handling splitVC
    self.splitViewController.delegate = self;
}

- (void) viewWillAppear: (BOOL) animated
{
 
    [super viewWillAppear: animated];
    
    [self updateContent];
}

#pragma mark - Segue -

- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    if ( [segue.identifier isEqualToString: @"ShowTaskDetailSegueId"] )
    {
        ProjectTask* task = [self.viewModel getSelectedProjectTask];

        self.taskDetailVC = (TaskDetailViewController*)[(UINavigationController*)segue.destinationViewController topViewController];
        
        [self.taskDetailVC fillSelectedTask: task];
    }
}


#pragma mark - Properties -

- (ProjectTasksViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [ProjectTasksViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    self.tasksByProjectTableView.dataSource = self.viewModel;
    self.tasksByProjectTableView.delegate   = self.viewModel;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.didShowTaskInfo = ^(){
        
        [blockSelf performSegueWithIdentifier: @"ShowTaskDetailSegueId"
                                       sender: blockSelf];
    };
}

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    if ( [self.delegate respondsToSelector: @selector(showMainMenu)] )
    {
        [self.delegate showMainMenu];
    }
}


- (IBAction) onSortTasks: (UIBarButtonItem*) sender
{
    [self showPopoverWithDataSource: self.viewModel
                       withDelegate: self.viewModel
                    withSourceFrame: [self getFrameForSortingPopover]];
}

- (void) updateContent
{
    @weakify(self)
    
    [[self.viewModel updateContent]
     subscribeCompleted: ^{
         
         @strongify(self)
         
         [self.tasksByProjectTableView reloadData];
         
     }];
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАДАЧИ ПО ПРОЕКТАМ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
}

- (void) needToUpdateContent
{
    [self updateContent];
}

- (CGRect) getFrameForSortingPopover
{
    CGRect barButtonFrame = self.onSortTasks.customView.bounds;
    
    CGRect newFrame = CGRectMake(CGRectGetWidth(self.view.frame) - 70,
                                 barButtonFrame.origin.y + 50,
                                 barButtonFrame.size.width,
                                 barButtonFrame.size.height);
    
    return newFrame;
}


#pragma mark - UISplitViewControllerDelegate methods -

- (BOOL)    splitViewController: (UISplitViewController*) splitViewController
collapseSecondaryViewController: (UIViewController*)      secondaryViewController
      ontoPrimaryViewController: (UIViewController*)      primaryViewController
{
    return YES;
}

- (BOOL) splitViewController: (UISplitViewController*) splitViewController
    showDetailViewController: (UIViewController*)      vc
                      sender: (id)                     sender
{
    return NO;
}

@end
