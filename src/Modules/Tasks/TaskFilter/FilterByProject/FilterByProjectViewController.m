//
//  FilterByProjectViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 28.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByProjectViewController.h"

// Classes
#import "FilterByProjectViewModel.h"

@interface FilterByProjectViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UITableView* filterByProjectTableView;

@property (weak, nonatomic) IBOutlet UIButton* selectAllBtn;

// properties
@property (strong, nonatomic) FilterByProjectViewModel* viewModel;

// methods
- (IBAction) onBackBtn: (UIBarButtonItem*) sender;

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender;

- (IBAction) onSelectBtn: (UIButton*) sender;

- (IBAction) onSaveBtn: (UIButton*) sender;

@end

@implementation FilterByProjectViewController


#pragma mark - Lyfe cycle -

- (void) loadView
{
    [super loadView];
    
    [self setupDefaults];
}


#pragma mark - Properties -

- (FilterByProjectViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [FilterByProjectViewModel new];
    }
    
    return _viewModel;
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

- (IBAction) onSelectBtn: (UIButton*) sender
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

- (IBAction) onSaveBtn: (UIButton*) sender
{
    [self saveData];
}


#pragma mark - Public -

- (void) fillSelectedProjects: (NSArray*) projects
                  withIndexes: (NSArray*) indexes
                 withDelegate: (id)       deletate
{
    [self.viewModel fillSelectedProjects: projects
                             withIndexes: indexes];
    
    self.delegate = deletate;
}



#pragma mark - Internal -

- (void) setupDefaults
{
    self.filterByProjectTableView.dataSource = self.viewModel;
    self.filterByProjectTableView.delegate   = self.viewModel;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^() {
        
        [blockSelf.filterByProjectTableView reloadData];
        
    };
    
    self.selectAllBtn.selected = [self.viewModel checkIfAllSelected] ? UIControlStateSelected : UIControlStateNormal;
}

- (void) saveData
{
    if ( [self.delegate respondsToSelector:@selector(returnSelectedProjects:withIndexes:)] )
    {
        [self.delegate returnSelectedProjects: [self.viewModel getSelectedProjectsArray]
                                  withIndexes: [self.viewModel getSelectedProjectsIndexes]];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}

@end
