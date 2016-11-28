//
//  FilterBySystemsViewController.m
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterBySystemsViewController.h"

//Classes
#import "FilterBySystemViewModel.h"

@interface FilterBySystemsViewController ()

// Properties
@property (weak, nonatomic) IBOutlet UITableView *systemsTableView;

@property (weak, nonatomic) IBOutlet UIButton* selectAllBtn;

@property (nonatomic, strong) FilterBySystemViewModel* viewModel;

// Methods
- (IBAction) onSaveBtn: (UIButton*) sender;
- (IBAction) onSelectAllBtn: (UIButton*) sender;

- (IBAction) onCanceledBtn: (UIBarButtonItem*) sender;
- (IBAction) onDoneBtn: (UIBarButtonItem*) sender;

@end

@implementation FilterBySystemsViewController

- (void) loadView
{
    [super loadView];
    
    self.systemsTableView.delegate   = self.viewModel;
    self.systemsTableView.dataSource = self.viewModel;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^() {
        
        [blockSelf.systemsTableView reloadData];
        
    };
    
    self.selectAllBtn.selected = [self.viewModel checkIfAllSelected] ? UIControlStateSelected : UIControlStateNormal;
}


#pragma mark - Properties -

- (FilterBySystemViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [FilterBySystemViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Public -

- (void) fillSelectedSystemsInfoFromConfig: (TaskFilterConfiguration *)filterConfig
{
    [self.viewModel fillSelectedSystemsInfoFromConfig: filterConfig];
}

#pragma mark - Actions -

- (IBAction) onSaveBtn: (UIButton*) sender
{
    [self saveData];
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


- (IBAction) onCanceledBtn: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    [self saveData];
}


#pragma mark - Internal -

- (void) saveData
{
    if ([self.delegate respondsToSelector: @selector(returnSelectedSystemsArray:withIndexes:)])
    {
        [self.delegate returnSelectedSystemsArray: [self.viewModel getSelectedSystems]
                                      withIndexes: [self.viewModel getSelectedSystemsIndexes]];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}


@end
