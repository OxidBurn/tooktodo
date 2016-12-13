//
//  FilterByTypesViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByTypesViewController.h"

//Classes
#import "FilterByTypesViewModel.h"
#import "TaskFilterConfiguration.h"

@interface FilterByTypesViewController ()

//Outlets
@property (nonatomic, weak) IBOutlet UITableView* typesTableView;

//Properties
@property (nonatomic, strong) FilterByTypesViewModel* viewModel;

// Methods
- (IBAction) onBackBtn: (UIBarButtonItem*) sender;

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender;

- (IBAction) onReset: (UIButton*) sender;

- (IBAction) onSave: (UIButton*) sender;


@end

@implementation FilterByTypesViewController


#pragma mark - Life cycle -

-(void) loadView
{
    [super loadView];
    
    self.typesTableView.dataSource = self.viewModel;
    self.typesTableView.delegate   = self.viewModel;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^(){
        
        [blockSelf.typesTableView reloadData];
        
    };
}

#pragma mark - Properties -

- (FilterByTypesViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [FilterByTypesViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Public -

- (void) fillSelectedTypesInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    [self.viewModel fillSelectedTypesInfoFromConfig: filterConfig];
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

- (IBAction) onReset: (UIButton*) sender
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

- (IBAction) onSave: (UIButton*) sender
{
    [self saveData];
}


#pragma mark - Internal -

- (void) saveData
{
    if ([self.delegate respondsToSelector: @selector(returnSelectedTypesArray:)])
    {
        [self.delegate returnSelectedTypesArray: [self.viewModel getSelectedTypesArray]];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}

@end
