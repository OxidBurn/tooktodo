//
//  TaskFilterViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskFilterViewController.h"

// Classes
#import "TaskFilterViewModel.h"
#import "BaseMainViewController+NavigationTitle.h"
#import "DataManager+ProjectInfo.h"
#import "FilterByDatesViewController.h"
#import "FilterByAssigneeViewController.h"
#import "FilterByStatusViewController.h"
#import "SelectSystemViewController.h"
#import "SelectRoomViewController.h"
#import "ProjectSystem+CoreDataProperties.h"
#import "FilterByTypesViewController.h"
#import "FilterByRoomViewController.h"
#import "FilterBySystemsViewController.h"

@interface TaskFilterViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UITableView* taskFilterTableView;

// properties
@property (strong, nonatomic) TaskFilterViewModel* viewModel;

@property (assign, nonatomic) FilterByDateViewControllerType controllerType;

@property (assign, nonatomic) TasksFilterType taskFilterType;

@property (assign, nonatomic) FilterByAssigneeType filterByAssigneeType;

@property (weak, nonatomic) id<TaskFilterViewControllerDelegate> delegate;

// methods
- (IBAction) onBackBtn: (UIBarButtonItem*) sender;
- (IBAction) onDoneBarButton: (UIBarButtonItem*) sender;
- (IBAction) onFilterBtn: (UIButton*) sender;
- (IBAction) onResetBtn: (UIButton*) sender;

@end

@implementation TaskFilterViewController


#pragma mark - Lyfe cycle -

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupDefaults];
}


#pragma mark - Segues -

- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    [super prepareForSegue: segue
                    sender: sender];
    
    TaskFilterConfiguration* filterConfig = [self.viewModel getFilterConfig];
    
    if ( [segue.identifier isEqualToString: @"ShowFilterByDatesSegueId"] )
    {
        FilterByDatesViewController* controller = [segue destinationViewController];
        
        [controller fillControllerType: self.controllerType
                      withFilterConfig: filterConfig
                          withDelegate: self.viewModel];
    }
    
    if ( [segue.identifier isEqualToString: @"FilterByCreatorSegueId"]     ||
         [segue.identifier isEqualToString: @"FilterByResponsibleSegueId"] ||
         [segue.identifier isEqualToString: @"FilterByApproversSegueId"]   )
    {
        FilterByAssigneeViewController* controller = [segue destinationViewController];
        
        [controller updateFilterType: self.filterByAssigneeType
                        withDelegate: self.viewModel];
        
        [controller fillSelectedUsersInfoFromConfig: filterConfig];
    }
    
    if ( [segue.identifier isEqualToString: @"FilterByStatusSegueId"] )
    {
        FilterByStatusViewController* controller = [segue destinationViewController];
        
        [controller fillDelegate: self.viewModel];
    }
    
    if ( [segue.identifier isEqualToString: @"ShowFilterByTypesSegueID"] )
    {
        FilterByTypesViewController* controller = [segue destinationViewController];
        
        [controller fillSelectedTypesInfoFromConfig: filterConfig];
        
        controller.delegate = self.viewModel;
    }
    
    if ( [segue.identifier isEqualToString: @"ShowFilterByRoomsSegueID"] )
    {
        FilterByRoomViewController* controller = [segue destinationViewController];
        
        [controller fillSelectedRoomsInfoFromConfig: filterConfig];
        
        controller.delegate = self.viewModel;
    }
    
    if ( [segue.identifier isEqualToString: @"ShowFilterBySystems"] )
    {
        FilterBySystemsViewController* controller = [segue destinationViewController];
        
        [controller fillSelectedSystemsInfoFromConfig: filterConfig];
        
        controller.delegate = self.viewModel;
    }
}


#pragma mark - Properties -

- (TaskFilterViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [TaskFilterViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Public -

- (void) fillFilterType: (TasksFilterType)                      filterType
           withDelegate: (id<TaskFilterViewControllerDelegate>) delegate
{
    self.delegate       = delegate;
    self.taskFilterType = filterType;
    
    [self.viewModel fillFilterType: filterType];
}


#pragma mark - Actions -

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

- (IBAction) onDoneBarButton: (UIBarButtonItem*) sender
{
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel saveFilterConfigurationWithCompletion: ^(BOOL isSuccess) {
        
        [blockSelf dismissViewControllerAnimated: YES
                                      completion: nil];
        
    }];
}

- (IBAction) onFilterBtn: (UIButton*) sender
{
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel saveFilterConfigurationWithCompletion: ^(BOOL isSuccess) {
        
        if ( [blockSelf.delegate respondsToSelector: @selector(applyFilterForTasks)] )
        {
            [blockSelf.delegate applyFilterForTasks];
        }
        
        [blockSelf dismissViewControllerAnimated: YES
                                      completion: nil];
        
    }];
}

- (IBAction) onResetBtn: (UIButton*) sender
{
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel resetFilterConfigurationForCurrentProject: ^(BOOL isSuccess) {
        
        if ( [blockSelf.delegate respondsToSelector: @selector(resetFilterForTasks)] )
        {
            [blockSelf.delegate resetFilterForTasks];
        }
        
        [blockSelf dismissViewControllerAnimated: YES
                                      completion: nil];
        
    }];
}


#pragma mark - Internal -

- (void) setupDefaults
{
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ФИЛЬТР ЗАДАЧ"
                                               withSubTitle: [DataManagerShared getSelectedProjectName]];
    
    self.taskFilterTableView.dataSource = self.viewModel;
    self.taskFilterTableView.delegate   = self.viewModel;
    
    __weak typeof(self) blockSelf = self;
    
    blockSelf.viewModel.showFilterByTermsWithType = ^(FilterByDateViewControllerType controllerType){
        
        self.controllerType = controllerType;
        
        [self performSegueWithIdentifier: @"ShowFilterByDatesSegueId"
                                  sender: self];
    };
    
    blockSelf.viewModel.showFilterByAssigneeWithType = ^(FilterByAssigneeType filterType, NSString* segueId){
      
        self.filterByAssigneeType = filterType;
        
        [blockSelf performSegueWithIdentifier: segueId
                                       sender: blockSelf];
    };
    
    blockSelf.viewModel.reloadTableView = ^(){
      
        [self.taskFilterTableView reloadData];
    };
    
    blockSelf.viewModel.showControllerWithSegueId = ^ (NSString* segueId) {
      
        if ( segueId )
            [blockSelf performSegueWithIdentifier: segueId
                                           sender: blockSelf];
    };
}


@end
