//
//  TaskViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailViewController.h"

// Classes
#import "TaskDetailViewModel.h"

@interface TaskDetailViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UITableView* taskTableView;

// properties
@property (strong, nonatomic) TaskDetailViewModel* viewModel;

// methods
- (IBAction) onBackBtn:   (UIBarButtonItem*) sender;

- (IBAction) onChangeBtn: (UIBarButtonItem*) sender;

@end

@implementation TaskDetailViewController

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

- (TaskDetailViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [TaskDetailViewModel new];
    }
    
    return _viewModel;
}

#pragma mark - Actions -

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.viewModel deselectTask];
    
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onChangeBtn: (UIBarButtonItem*) sender
{
    
}

#pragma mark - Helpers -

- (void) setupDefaults
{
    self.taskTableView.dataSource = self.viewModel;
    self.taskTableView.delegate   = self.viewModel;
    
    self.taskTableView.rowHeight = UITableViewAutomaticDimension;
    self.taskTableView.estimatedRowHeight = 58;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^(){
        
        [blockSelf.taskTableView reloadData];
        
    };
}

@end
