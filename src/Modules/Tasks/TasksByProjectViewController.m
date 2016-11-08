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

@interface TasksByProjectViewController () <UISplitViewControllerDelegate>

// Properties

@property (weak, nonatomic) IBOutlet UITableView* tasksByProjectTableView;

@property (strong, nonatomic) AllTasksViewModel* viewModel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem* filterBtn;


// Methods
- (IBAction) onShowTaskFilter: (UIBarButtonItem*) sender;

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
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}

- (IBAction) onShowTaskFilter: (UIBarButtonItem*) sender
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
