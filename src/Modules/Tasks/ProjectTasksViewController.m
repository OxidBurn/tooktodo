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
#import "ProjectTask+CoreDataClass.h"
#import "ChangeStatusViewController.h"
#import "TaskFilterViewController.h"
#import "TaskFilterViewControllerDelegate.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"
#import "DataManager+ProjectInfo.h"
#import "BaseMainViewController+Popover.h"

@interface ProjectTasksViewController () <UISplitViewControllerDelegate, ChangeStatusControllerDelegate, TaskFilterViewControllerDelegate>

// Properties

@property (nonatomic, strong) ProjectTasksViewModel* viewModel;

// Outlets

@property (weak, nonatomic) IBOutlet UITableView* tasksByProjectTableView;
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;

@property (weak, nonatomic) IBOutlet UIBarButtonItem* onSortTasks;

// Methods

- (void) bindingUI;

// Actions
- (IBAction) onFilterBtn: (UIBarButtonItem*) sender;

- (IBAction) onSortTasks: (UIBarButtonItem*) sender;


@end

@implementation ProjectTasksViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
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
    
    [self setupTableView];
    
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
        
        [self.taskDetailVC refreshTableView];
    }
    else
    if ([segue.identifier isEqualToString: @"ShowStatusList"])
    {
        UINavigationController* destinationNavController = segue.destinationViewController;
        
        ChangeStatusViewController* vc = (ChangeStatusViewController*)destinationNavController.topViewController;
        
        vc.delegate = self;
    }
    else
    if ( [segue.identifier isEqualToString: @"ShowTaskFilteriPhone"] ||
         [segue.identifier isEqualToString: @"ShowTaskFilteriPad"])
    {
        UINavigationController* destinationNavController = segue.destinationViewController;

        TaskFilterViewController* vc = (TaskFilterViewController*)destinationNavController.topViewController;
        
        [vc fillFilterType: FilterBySingleProject
              withDelegate: self];
        
        
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
    self.searchBar.delegate                 = self.viewModel;
    
    __weak typeof(self) blockSelf = self;
       
    dispatch_async(dispatch_get_main_queue(), ^{
        
        self.viewModel.reloadTable = ^(){
            
            [blockSelf.tasksByProjectTableView reloadData];
        };
    });
    
    self.viewModel.performSegue = ^(NSString* segueID) {
        
        [blockSelf performSegueWithIdentifier: segueID
                                       sender: blockSelf];
    };
    
    self.viewModel.endSearching = ^(){
        
        [blockSelf.searchBar resignFirstResponder];
        [blockSelf.view endEditing: YES];
        
    };
    
}

- (void) setupTableView
{
    [self.tasksByProjectTableView setContentOffset: CGPointMake(0, self.searchBar.height)];
}

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}


- (IBAction) onFilterBtn: (UIBarButtonItem*) sender
{
    NSString* segueId = IS_PHONE ? @"ShowTaskFilteriPhone" : @"ShowTaskFilteriPad";
    
    id customSender = IS_PHONE ? self : self.splitViewController;
    
    [self performSegueWithIdentifier: segueId
                              sender: customSender];
}

- (IBAction) onSortTasks: (UIBarButtonItem*) sender
{
    [self showPopoverWithDataSource: self.viewModel
                       withDelegate: self.viewModel
                    withSourceFrame: [self getFrameForSortingPopover]
                      withDirection: UIPopoverArrowDirectionUp];
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
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАДАЧИ"
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


#pragma mark - ChangeStatusControllerDelegate methods -

- (void) updataTaskDetailInfoTaskStatus
{
    [self.tasksByProjectTableView reloadData];
}


#pragma mark - Task filter delegate methods -

- (void) applyFilterForTasks
{
    [self updateContent];
}

- (void) resetFilterForTasks
{
    [self updateContent];
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
