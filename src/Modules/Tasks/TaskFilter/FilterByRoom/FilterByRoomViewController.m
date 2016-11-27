//
//  FilterByRoomViewController.m
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByRoomViewController.h"

//Classes
#import "FilterByRoomViewModel.h"

@interface FilterByRoomViewController ()
// Properties
@property (weak, nonatomic) IBOutlet UITableView *filterByRoomTableView;

@property (nonatomic, strong) FilterByRoomViewModel* viewModel;

// Methods
- (IBAction) onSaveBtn: (UIButton*) sender;
- (IBAction) onSelectAllBtn: (UIButton*) sender;

- (IBAction) onCanceledBtn: (UIBarButtonItem*) sender;
- (IBAction) onDoneBtn: (UIBarButtonItem*) sender;

@end

@implementation FilterByRoomViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    self.filterByRoomTableView.delegate   = self.viewModel;
    self.filterByRoomTableView.dataSource = self.viewModel;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^() {
        
        [blockSelf.filterByRoomTableView reloadData];
        
    };
}


#pragma mark - Properties -

- (FilterByRoomViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [FilterByRoomViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Public -

- (void) fillSelectedRoomsInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    [self.viewModel fillSelectedRoomsInfoFromConfig: filterConfig];
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
    if ([self.delegate respondsToSelector: @selector(returnSelectedRoomsArray:withIndexes:)])
    {
        [self.delegate returnSelectedRoomsArray: [self.viewModel getSelectedRooms]
                                    withIndexes: [self.viewModel getSelectedRoomIndexes]];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}

@end
