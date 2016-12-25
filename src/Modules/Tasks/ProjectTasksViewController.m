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
#import "FilterParametersManager.h"
#import "FilterParametersTagsView.h"
#import "FilterBarButton.h"

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
@property (weak, nonatomic) IBOutlet FilterParametersTagsView *filterParametersView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *filterParameterTagsViewHeightConstraint;
@property (weak, nonatomic) IBOutlet FilterBarButton *showFilterBtn;

@property (strong, nonatomic) FilterParametersManager* filterParameterManager;

// Methods

- (void) bindingUI;

// Actions
- (IBAction) onFilterBtn: (UIButton*) sender;

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
    

    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАДАЧИ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];

    [self needToUpdateContent];
    
    // Add observer for updating selected project content
    [DefaultNotifyCenter addObserver: self
                            selector: @selector(needToUpdateContent)
                                name: @"NeedToUpdateContent"
                              object: nil];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    [self setupTableView];
    
    [self updateContent];
}


#pragma mark - Memory managment -

- (void) dealloc
{
    [DefaultNotifyCenter removeObserver: self
                                   name: @"NeedToUpdateContent"
                                 object: nil];
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
    self.searchBar.delegate                 = self.viewModel;
    
    self.tasksByProjectTableView.rowHeight = UITableViewAutomaticDimension;
    
    self.filterParametersView.dataSource     = self.filterParameterManager;
    self.filterParametersView.filterDelegate = self.filterParameterManager;

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
        
        [blockSelf.tasksByProjectTableView setContentOffset: CGPointMake(0, blockSelf.searchBar.height)
                                                   animated: YES];
        
    };
    
    self.filterParametersView.updateHeight = ^( CGFloat height ){
        
        // Filters parameters tags view height should be not bigger than
        // 20% of the screen height
        CGFloat maxHeight = (blockSelf.view.height / 5);
        
        if ( height < maxHeight )
            blockSelf.filterParameterTagsViewHeightConstraint.constant = height;
        else
            blockSelf.filterParameterTagsViewHeightConstraint.constant = maxHeight;
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.01 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [blockSelf setupTableView];
        });
    };
    
    self.filterParameterManager.didUpdateFilter = ^(NSUInteger count){
        
        [[blockSelf.viewModel updateContent]
         subscribeNext: ^(id x) {
             
             [blockSelf.tasksByProjectTableView reloadData];
             
         }];
        
        [blockSelf.showFilterBtn updateFilterParametersCount: count];
        
        [blockSelf.tasksByProjectTableView reloadData];
        
    };
    

}

- (void) setupTableView
{
    [self.tasksByProjectTableView setContentOffset: CGPointMake(0, self.searchBar.height)
                                          animated: NO];
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
    
    // Filter parameters
    __weak typeof(self) blockSelf = self;
    
    [self.filterParameterManager updateFilterContentForScreen: ProjectTaskScreenType
                                               withCompletion: ^(NSUInteger parametersCount) {
                                                   
                                                   [blockSelf.filterParametersView reloadContent];
                                                   
                                                   [blockSelf.showFilterBtn updateFilterParametersCount: parametersCount];
                                                   
                                               }];
}

- (void) needToUpdateContent
{
    @weakify(self)
    
    [[self.viewModel loadUpdatedContentFromServer] subscribeCompleted:^{
        
        @strongify(self)
        
        [self.tasksByProjectTableView reloadData];
        
    }];
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАДАЧИ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
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
