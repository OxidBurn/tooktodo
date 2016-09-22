//
//  FilterForResponsibleViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectResponsibleViewController.h"

// Classes
#import "SelectResponsibleViewModel.h"

@interface SelectResponsibleViewController ()

// Outlets
@property (weak, nonatomic) IBOutlet UITableView* selectResponsibleTableView;
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;

// Properties
@property (strong, nonatomic) SelectResponsibleViewModel* viewModel;

// Methods
- (IBAction) onSelectedAllBtn: (UIButton*) sender;
- (IBAction)        onSaveBtn: (UIButton*) sender;
- (IBAction)        onDoneBtn: (UIBarButtonItem*) sender;
- (IBAction)        onBackBtn: (UIBarButtonItem*) sender;


@end

@implementation SelectResponsibleViewController

#pragma mark - Life cycle -

- (void)loadView
{
    [super loadView];
    
    [self setupDefaults];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties -

- (SelectResponsibleViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [SelectResponsibleViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Actions -

- (IBAction) onSelectedAllBtn: (UIButton*) sender
{
    
}

- (IBAction) onSaveBtn: (UIButton*) sender
{
    
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    
}

#pragma mark - Internal -

- (void) setupDefaults
{
    self.selectResponsibleTableView.dataSource = self.viewModel;
    self.selectResponsibleTableView.delegate   = self.viewModel;
}

@end
