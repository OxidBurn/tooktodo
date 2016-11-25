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

@interface TaskFilterViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UITableView* taskFilterTableView;

// properties
@property (strong, nonatomic) TaskFilterViewModel* viewModel;

@property (assign, nonatomic) FilterByDateViewControllerType controllerType;

@property (assign, nonatomic) TasksFilterType taskFilterType;

@property (assign, nonatomic) FilterByAssigneeType filterByAssigneeType;

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
    
    if ( [segue.identifier isEqualToString: @"ShowFilterByDatesSegueId"] )
    {
        FilterByDatesViewController* controller = [segue destinationViewController];
        
        [controller fillControllerType: self.controllerType];
    }
    
    if ( [segue.identifier isEqualToString: @"FilterByCreatorSegueId"]     ||
         [segue.identifier isEqualToString: @"FilterByResponsibleSegueId"] ||
         [segue.identifier isEqualToString: @"FilterByApproversSegueId"]   )
    {
        FilterByAssigneeViewController* controller = [segue destinationViewController];
        
        [controller updateFilterType: self.filterByAssigneeType
                        withDelegate: self.viewModel];
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

- (void) fillFilterType: (TasksFilterType) filterType
{
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
        
        [blockSelf dismissViewControllerAnimated: YES
                                      completion: nil];
        
    }];
}

- (IBAction) onResetBtn: (UIButton*) sender
{
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel resetFilterConfigurationForCurrentProject: ^(BOOL isSuccess) {
        
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
}


@end
