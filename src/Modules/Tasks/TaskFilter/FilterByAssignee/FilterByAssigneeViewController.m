//
//  FilterByAssigneeViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 24.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByAssigneeViewController.h"

// Classes
#import "FilterByAssigneeViewModel.h"
#import "ProjectsEnumerations.h"

@interface FilterByAssigneeViewController ()

// Outlets
@property (weak, nonatomic) IBOutlet UITableView*        filterByAssigneeTableView;
@property (weak, nonatomic) IBOutlet UISearchBar*        searchBar;
@property (weak, nonatomic) IBOutlet UIButton*           selectAllBtn;
@property (weak, nonatomic) IBOutlet UIButton*           saveBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem*    doneBtn;

// Properties
@property (strong, nonatomic) FilterByAssigneeViewModel* viewModel;

@property (assign, nonatomic) FilterByAssigneeType filterType;

@property (nonatomic, assign) SelectResponsibleSelectAllFlag selectAllFlag;

// Methods
- (IBAction) onSaveBtn     : (UIButton*)        sender;
- (IBAction) onDoneBtn     : (UIBarButtonItem*) sender;
- (IBAction) onBackBtn     : (UIBarButtonItem*) sender;
- (IBAction) onSelectAllBtn: (UIButton*)        sender;

@end

@implementation FilterByAssigneeViewController


#pragma mark - Life cycle -

- (void)loadView
{
    [super loadView];
    
    [self setupDefaults];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
//    self.controllerTypeSelection = [self.viewModel returnControllerType];
}


#pragma mark - Properties -

- (FilterByAssigneeViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [FilterByAssigneeViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Actions -

- (IBAction) onSaveBtn: (UIButton*) sender
{
    [self saveData];
}

- (IBAction) deselectAll: (UIButton*) sender
{
    [self.viewModel deselectAll];
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    [self saveData];
}

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onSelectAllBtn: (UIButton*) sender
{
    [self.viewModel selectAll];
}


#pragma mark - Pulbic -

- (void) updateFilterType: (FilterByAssigneeType) filterType
             withDelegate: (id)                   delegate
{
    self.filterType = filterType;
    
    [self.viewModel fillFilterType: filterType];
    
    self.delegate = delegate;
}

- (void) fillSelectedUsersInfo: (NSArray*) selectedUsers
{
//    [self.viewModel fillSelectedUsersInfo: selectedUsers];
}

#pragma mark - Internal -

- (void) setupDefaults
{
    self.filterByAssigneeTableView.dataSource = self.viewModel;
    self.filterByAssigneeTableView.delegate   = self.viewModel;
        
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^(){
        
        [blockSelf.filterByAssigneeTableView reloadData];
        
    };
}


- (void) saveData
{
    [self.viewModel saveSelectedAssignees];
}




@end