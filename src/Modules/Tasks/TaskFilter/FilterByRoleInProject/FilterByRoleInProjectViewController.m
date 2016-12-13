//
//  FilterByRoleInProjectViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByRoleInProjectViewController.h"

// Classes
#import "FilterByRoleInProjectViewModel.h"

@interface FilterByRoleInProjectViewController ()

// Outlets
@property (nonatomic, weak) IBOutlet UITableView* rolesTableView;

// Properties
@property (nonatomic, strong) FilterByRoleInProjectViewModel* viewModel;

// Methods
- (IBAction) onBackBtn: (UIBarButtonItem*) sender;

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender;

- (IBAction) onSave: (UIButton*) sender;

@end

@implementation FilterByRoleInProjectViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    self.rolesTableView.dataSource = self.viewModel;
    self.rolesTableView.delegate   = self.viewModel;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^(){
        
        [blockSelf.rolesTableView reloadData];
        
    };
}


#pragma mark - Properties -

- (FilterByRoleInProjectViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [FilterByRoleInProjectViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Public -

- (void) fillSelectedRoleType: (NSNumber*) roleType
{
    [self.viewModel fillSelectedRoleType: roleType];
}


#pragma mark - Actions -

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    [self saveData];
}

- (IBAction) onSave: (UIButton*) sender
{
    [self saveData];
}


#pragma mark - Internal -

- (void) saveData
{
    if ([self.delegate respondsToSelector: @selector(returnSelectedRoleType:)])
    {
        [self.delegate returnSelectedRoleType: [self.viewModel getSelectedRoleType]];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}

@end
