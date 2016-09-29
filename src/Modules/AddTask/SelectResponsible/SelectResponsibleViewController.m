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
#import "ProjectsEnumerations.h"

@interface SelectResponsibleViewController ()

// Outlets
@property (weak, nonatomic) IBOutlet UITableView*        selectResponsibleTableView;
@property (weak, nonatomic) IBOutlet UISearchBar*        searchBar;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint* saveBtnLeadingConstraint;
@property (weak, nonatomic) IBOutlet UIButton*           selectAllBtn;
@property (weak, nonatomic) IBOutlet UIButton*           saveBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem*    doneBtn;

// Properties
@property (strong, nonatomic) SelectResponsibleViewModel* viewModel;

@property (assign, nonatomic) ControllerTypeSelection controllerTypeSelection;

@property (nonatomic, assign) SelectResponsibleSelectAllFlag selectAllFlag;

// Methods
- (IBAction) onSaveBtn     : (UIButton*)        sender;
- (IBAction) onDoneBtn     : (UIBarButtonItem*) sender;
- (IBAction) onBackBtn     : (UIBarButtonItem*) sender;
- (IBAction) onSelectAllBtn: (UIButton*)        sender;


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
    
    self.controllerTypeSelection = [self.viewModel returnControllerType];
    
    [self handleUI];
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
    NSArray* selectedUsers = [self.viewModel returnSelectedUsersInfo];
    
    if ( selectedUsers && [self.delegate respondsToSelector: @selector(returnSelectedResponsibleInfo:)] )
    {
        [self.delegate returnSelectedResponsibleInfo: selectedUsers];
        
        [self.navigationController popViewControllerAnimated: YES];
    }
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onSelectAllBtn: (UIButton*) sender
{
    switch (self.selectAllFlag)
    {
        case SelectAll:
        {
            [self.viewModel selectAll];
            [self.selectAllBtn setTitle: @"Сбросить"
                               forState: UIControlStateNormal];
            self.selectAllFlag = DeselectAll;
        }
            break;
        case DeselectAll:
        {
            [self.viewModel deselectAll];
            [self.selectAllBtn setTitle: @"Выбрать всех"
                               forState: UIControlStateNormal];
            self.selectAllFlag = SelectAll;
        }
        default:
            break;
    }
    
}

#pragma mark - Pulbic -

- (void) updateControllerType: (ControllerTypeSelection) controllerType
                 withDelegate: (id)                      delegate
{
    [self.viewModel fillContollerTypeSelection: controllerType];

    self.delegate = delegate;
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

- (void) handleUI
{
    switch ( self.controllerTypeSelection )
    {
        case SelectResponsibleController:
        {
            [self.selectAllBtn setHidden: YES];
            
            self.saveBtnLeadingConstraint.constant = 0;
            self.saveBtnLeadingConstraint.priority = 1000;
        }
            break;
            
        case SelectClaimingController:
        {
            [self.selectAllBtn setHidden: YES];
            
            self.saveBtnLeadingConstraint.constant = 0;
            self.saveBtnLeadingConstraint.priority = 1000;
        }
            
            break;
            
        case SelectObserversController:
        {
            self.selectAllBtn.hidden = NO;
            
            self.saveBtnLeadingConstraint.priority = 250;
        }
            
            break;
            
        default:
            break;
    }
}


@end
