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

@property (assign, nonatomic) ControllerMarkOption controllerMarkOption;

// Methods
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

- (void) viewDidLoad
{
    [super viewDidLoad];
}


- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    // Update team info when appeared screen
    // made for immediate update team info after
    // switching between projects or adding new member to the team
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel updateInfoWithCompletion: ^(BOOL isSuccess) {
        
        if ( isSuccess )
        {
            [blockSelf.selectResponsibleTableView reloadData];
        }
        
    }];
}

#pragma mark - Initialization -

- (instancetype) initWithMarkOption: (ControllerMarkOption) markOption
{
    self = [super init];
    
    if ( self )
    {
        self.controllerMarkOption = markOption;
    }
    
    return self;
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

- (IBAction) onSaveBtn: (UIButton*) sender
{
    
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

#pragma mark - Pulbic -

- (void) setOption: (ControllerMarkOption) option
{
    [self.viewModel fillContollerMarkOption: option];

}


#pragma mark - Internal -

- (void) setupDefaults
{
    self.selectResponsibleTableView.dataSource = self.viewModel;
    self.selectResponsibleTableView.delegate   = self.viewModel;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^(){
        
        [blockSelf.selectResponsibleTableView reloadData];
        
    };
}

@end
