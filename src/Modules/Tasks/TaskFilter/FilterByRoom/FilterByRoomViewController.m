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

@property (nonatomic, weak) IBOutlet UITableView* roomsTableView;

@property (nonatomic, strong) FilterByRoomViewModel* viewModel;

@end

@implementation FilterByRoomViewController

- (FilterByRoomViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [FilterByRoomViewModel new];
    }
    
    return _viewModel;
}

- (void) loadView
{
    [super loadView];
    
    self.roomsTableView.delegate   = self.viewModel;
    self.roomsTableView.dataSource = self.viewModel;
}

@end
