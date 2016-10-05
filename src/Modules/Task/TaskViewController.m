//
//  TaskViewController.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskViewController.h"

// Classes
#import "TaskViewModel.h"

@interface TaskViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UITableView* taskTableView;

// properties
@property (strong, nonatomic) TaskViewModel* viewModel;

// methods
- (IBAction) onBackBtn:   (UIBarButtonItem*) sender;

- (IBAction) onChangeBtn: (UIBarButtonItem*) sender;

@end

@implementation TaskViewController

#pragma mark - Lyfe cycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupDefaults];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties -

- (TaskViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [TaskViewModel new];
    }
    
    return _viewModel;
}

#pragma mark - Actions -

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onChangeBtn: (UIBarButtonItem*) sender
{
    
}

#pragma mark - Helpers -

- (void) setupDefaults
{
    self.taskTableView.dataSource = self.viewModel;
    self.taskTableView.delegate   = self.viewModel;
}


@end
