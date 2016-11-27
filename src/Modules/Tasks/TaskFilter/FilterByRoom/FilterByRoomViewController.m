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
    
}

#pragma mark - Actions -

- (IBAction) onSaveBtn: (UIButton*) sender
{
    
}

- (IBAction) onSelectAllBtn: (UIButton*) sender
{
    
}
- (IBAction) onResetBtn: (UIButton*) sender
{
    
}

- (IBAction) onCanceledBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    
}


#pragma mark - Internal -

- (void) saveData
{
    if ([self.delegate respondsToSelector: @selector(returnSelectedRoomsArray:withIndexes:)])
    {
        [self.delegate returnSelectedRoomsArray: [self.viewModel getSelectedRooms]
                                    withIndexes: [self.viewModel getSelectedRoomIndexes]];
    }
}

@end
