//
//  SelectSystemViewController.m
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectSystemViewController.h"

//Classes
#import "SelectSystemViewModel.h"

@interface SelectSystemViewController ()

// Outlets

@property (weak, nonatomic) IBOutlet UITableView *systemsTableView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *readyBtn;

// Properties

@property (nonatomic, strong) SelectSystemViewModel* viewModel;

@end

@implementation SelectSystemViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self bindUI];
}

#pragma mark - Properties -

- (SelectSystemViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [SelectSystemViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Public -

- (void) fillSelectedSystem: (ProjectSystem*)                          system
               withDelegate: (id <SelectSystemViewControllerDelegate>) delegate
{
    [self.viewModel fillSelectedSystem: system];
    
    self.delegate = delegate;
}

#pragma mark - Internal -

- (void) bindUI
{
    self.systemsTableView.delegate   = self.viewModel;
    self.systemsTableView.dataSource = self.viewModel;
}

- (void) saveData
{
    ProjectSystem* selectedSystem = [self.viewModel getSelectedSystem];
    
    if ( [self.delegate respondsToSelector: @selector(returnSelectedSystem:)] )
    {
        [self.delegate returnSelectedSystem: selectedSystem];
        
        [self.navigationController popViewControllerAnimated: YES];
    }
}

#pragma mark - Actions -

- (IBAction) onCancel: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onReady: (id) sender
{
    [self saveData];
}


@end
