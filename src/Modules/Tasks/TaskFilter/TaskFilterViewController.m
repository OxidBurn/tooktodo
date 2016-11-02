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

@interface TaskFilterViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UITableView* taskFilterTableView;

// properties
@property (strong, nonatomic) TaskFilterViewModel* viewModel;

// methods
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

#pragma mark - Properties -

- (TaskFilterViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [TaskFilterViewModel new];
    }
    
    return _viewModel;
}

#pragma mark - Actions -

- (IBAction) onDoneBarButton: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onFilterBtn: (UIButton*) sender
{
    
}

- (IBAction) onResetBtn: (UIButton*) sender
{
    
}

#pragma mark - Internal -

- (void) setupDefaults
{
    self.taskFilterTableView.dataSource = self.viewModel;
    self.taskFilterTableView.delegate   = self.viewModel;
}


@end
