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
@property (weak, nonatomic) IBOutlet UIButton*           resetBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem*    doneBtn;

// Properties
@property (strong, nonatomic) FilterByAssigneeViewModel* viewModel;

@property (assign, nonatomic) FilterByAssigneeType filterType;

@property (nonatomic, assign) SelectResponsibleSelectAllFlag selectAllFlag;

// Methods
- (IBAction) onSaveData    : (UIButton*)        sender;
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

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    [self setupTableView];
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

- (IBAction) onSaveData: (UIButton*) sender
{
    [self saveData];
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
    if ( sender.selected )
    {
        [self.viewModel deselectAll];
    }
    else
    {
        [self.viewModel selectAll];
    }
    
    sender.selected = !sender.selected;
}


#pragma mark - Pulbic -

- (void) updateFilterType: (FilterByAssigneeType) filterType
             withDelegate: (id)                   delegate
{
    self.filterType = filterType;
    
    [self.viewModel fillFilterType: filterType];
    
    self.delegate = delegate;
}

- (void) fillSelectedUsersInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    [self.viewModel fillSelectedUsersInfoFromConfig: filterConfig];
}

#pragma mark - Internal -

- (void) setupDefaults
{
    self.filterByAssigneeTableView.dataSource = self.viewModel;
    self.filterByAssigneeTableView.delegate   = self.viewModel;
    self.searchBar.delegate                   = self.viewModel;
        
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^(){
        
        [blockSelf.filterByAssigneeTableView reloadData];
        
    };
    
    self.viewModel.endSearching = ^(){
        
        [blockSelf.searchBar resignFirstResponder];
        [blockSelf.view endEditing: YES];
        
    };
    
    self.selectAllBtn.selected =  [self.viewModel checkIfAllSelected] ? UIControlStateSelected : UIControlStateNormal;
}

- (void) setupTableView
{
    [self.filterByAssigneeTableView setContentOffset: CGPointMake(0, self.searchBar.height)];
}


- (void) saveData
{
    if ( [self.delegate respondsToSelector: @selector(returnSelectedAssigneesArray:withFilterType:withIndexes:)] )
        [self.delegate returnSelectedAssigneesArray: [self.viewModel getSelectedAssignees]
                                     withFilterType: self.filterType
                                        withIndexes: [self.viewModel getSelectedAssingeesIndexes]];
    
    [self.navigationController popViewControllerAnimated: YES];
}




@end
