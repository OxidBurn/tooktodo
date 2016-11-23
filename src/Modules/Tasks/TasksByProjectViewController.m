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
#import "ProjectTask+CoreDataClass.h"
#import "TaskFilterViewController.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"
#import "DataManager+ProjectInfo.h"
#import "BaseMainViewController+Popover.h"

@interface TasksByProjectViewController () <UISplitViewControllerDelegate>

// Properties

@property (weak, nonatomic) IBOutlet UITableView* tasksByProjectTableView;

@property (strong, nonatomic) AllTasksViewModel* viewModel;

@property (nonatomic, weak) IBOutlet UIBarButtonItem* sortTasksBtn;

// Methods
- (IBAction) onShowTasksFilter: (UIBarButtonItem*) sender;

- (void) bindingUI;

@end

@implementation TasksByProjectViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАДАЧИ ПО ПРОЕКТАМ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
    
    if (IS_PHONE == NO)
    {
        self.navigationItem.leftBarButtonItem = nil;
    }
    
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


#pragma mark - Segue -

- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    if ( [segue.identifier isEqualToString: @"ShowTaskDetailSegueID"] )
    {
        ProjectTask* task = [self.viewModel getSelectedProjectTask];
        
        self.taskDetailVC = (TaskDetailViewController*)[(UINavigationController*)segue.destinationViewController topViewController];
        
        [self.taskDetailVC fillSelectedTask: task];
        
        [self.taskDetailVC refreshTableView];
    }
    
    if ( [segue.identifier isEqualToString: @"ShowTaskFilteriPhone"] ||
         [segue.identifier isEqualToString: @"ShowTaskFilteriPad"])
    {
        UINavigationController* destinationNavController = segue.destinationViewController;
        
        TaskFilterViewController* vc = (TaskFilterViewController*)destinationNavController.topViewController;
        
        [vc fillFilterType: FilterByAllProjects];
    }
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
    
    self.viewModel.reloadTable = ^(){
        
        [blockSelf.tasksByProjectTableView reloadData];
    };
}

- (void) willGetFocus
{
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАДАЧИ ПО ПРОЕКТАМ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
}

- (CGRect) getFrameForSortingPopover
{
    CGRect barButtonFrame = self.sortTasksBtn.customView.bounds;
    
    CGRect newFrame = CGRectMake(CGRectGetWidth(self.view.frame) - 70,
                                 barButtonFrame.origin.y + 50,
                                 barButtonFrame.size.width,
                                 barButtonFrame.size.height);
    
    return newFrame;
}


#pragma mark - Actions -

- (IBAction) onShowMenu: (UIBarButtonItem*) sender
{
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}

- (IBAction) onSortTasks: (UIBarButtonItem*) sender
{
    [self showPopoverWithDataSource: self.viewModel
                       withDelegate: self.viewModel
                    withSourceFrame: [self getFrameForSortingPopover]
                      withDirection: UIPopoverArrowDirectionUp];
}

- (IBAction)onShowTasksFilter: (UIBarButtonItem*) sender
{
    NSString* segueId = IS_PHONE ? @"ShowTaskFilteriPhone" : @"ShowTaskFilteriPad";
    
    id customSender = IS_PHONE ? self : self.splitViewController;
    
    [self performSegueWithIdentifier: segueId
                              sender: customSender];
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
