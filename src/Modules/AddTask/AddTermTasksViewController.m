//
//  AddTermTasksViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTermTasksViewController.h"

// Classes
#import "AddTaskTermsViewModel.h"

@interface AddTermTasksViewController () <AddTaskTermsViewModelDelegate>

// outlets
@property (weak, nonatomic) IBOutlet UITableView* addTermTasksTableView;

// properties
@property (strong, nonatomic) AddTaskTermsViewModel* viewModel;

// methods
- (IBAction) onDoneBtn: (UIBarButtonItem*) sender;
- (IBAction) onBackBtn: (UIBarButtonItem*) sender;
- (IBAction) onSaveBtn: (UIButton*) sender;


@end

@implementation AddTermTasksViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self setUpDefaults];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties -

- (AddTaskTermsViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [AddTaskTermsViewModel new];
        
        _viewModel.delegate = self;
    }
    
    return _viewModel;
}

#pragma mark - Action -

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onSaveBtn: (UIButton*) sender
{
    
}

#pragma mark - Internal -

- (void) setUpDefaults
{
    self.addTermTasksTableView.dataSource = self.viewModel;
    self.addTermTasksTableView.delegate   = self.viewModel;
}

#pragma mark - AddTaskTermsViewModelDelegate methods -

- (void) reloadAddTaskTableView
{
    [self.addTermTasksTableView reloadData];
}

@end
