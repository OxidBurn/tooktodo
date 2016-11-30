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
#import "TaskFilterViewControllerDelegate.h"
#import "FilterBarButton.h"
#import "FilterParametersTagsView.h"
#import "FilterParametersManager.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"
#import "DataManager+ProjectInfo.h"
#import "BaseMainViewController+Popover.h"

@interface TasksByProjectViewController () <UISplitViewControllerDelegate, TaskFilterViewControllerDelegate>

// Properties

@property (weak, nonatomic) IBOutlet UITableView* tasksByProjectTableView;

@property (strong, nonatomic) AllTasksViewModel* viewModel;

@property (nonatomic, weak) IBOutlet UIBarButtonItem* sortTasksBtn;
@property (weak, nonatomic) IBOutlet FilterBarButton *showFilterBtn;
@property (weak, nonatomic) IBOutlet FilterParametersTagsView *filterParametersView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterParameterTagsViewHeightConstraint;

@property (strong, nonatomic) FilterParametersManager* filterParameterManager;

// Methods
- (IBAction) onShowTasksFilter: (UIButton*) sender;

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
    
    [self updateContent];
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
        
        [vc fillFilterType: FilterByAllProjects
              withDelegate: self];
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

- (FilterParametersManager*) filterParameterManager
{
    if ( _filterParameterManager == nil )
    {
        _filterParameterManager = [FilterParametersManager new];
    }
    
    return _filterParameterManager;
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    self.tasksByProjectTableView.dataSource = self.viewModel;
    self.tasksByProjectTableView.delegate   = self.viewModel;
    
    self.filterParametersView.dataSource     = self.filterParameterManager;
    self.filterParametersView.filterDelegate = self.filterParameterManager;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.didShowTaskInfo = ^(NSString* segueId){
        
        [blockSelf performSegueWithIdentifier: @"ShowTaskDetailSegueID"
                                       sender: blockSelf];
        
    };
    
    self.viewModel.reloadTable = ^(){
        
        [blockSelf.tasksByProjectTableView reloadData];
    };
    
    self.filterParametersView.updateHeight = ^( CGFloat height ){
        
        // Filters parameters tags view height should be not bigger than
        // 20% of the screen height
        CGFloat maxHeight = (blockSelf.view.height / 5);
        
        if ( height < maxHeight )
            blockSelf.filterParameterTagsViewHeightConstraint.constant = height;
        else
            blockSelf.filterParameterTagsViewHeightConstraint.constant = maxHeight;
        
    };
    
    self.filterParameterManager.didUpdateFilter = ^(NSUInteger count){
        
        [[blockSelf.viewModel updateContent]
         subscribeCompleted: ^{
             
             [blockSelf.tasksByProjectTableView reloadData];
             
         }];
        
        [blockSelf.showFilterBtn updateFilterParametersCount: count];
        
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

- (void) updateContent
{
    @weakify(self)
    
    [[self.viewModel updateContent]
     subscribeCompleted: ^{
         
         @strongify(self)
         
         [self.tasksByProjectTableView reloadData];
         
     }];
    
    // Filter parameters
    __weak typeof(self) blockSelf = self;
    
    [self.filterParameterManager updateFilterContentForScreen: AllProjectTasksScreenType
                                               withCompletion: ^(NSUInteger parametersCount) {
                                                   
                                                   [blockSelf.filterParametersView reloadContent];
                                                   
                                                   [blockSelf.showFilterBtn updateFilterParametersCount: parametersCount];
                                                   
                                               }];
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

- (IBAction) onShowTasksFilter: (UIBarButtonItem*) sender
{
    NSString* segueId = IS_PHONE ? @"ShowTaskFilteriPhone" : @"ShowTaskFilteriPad";
    
    id customSender = IS_PHONE ? self : self.splitViewController;
    
    [self performSegueWithIdentifier: segueId
                              sender: customSender];
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
