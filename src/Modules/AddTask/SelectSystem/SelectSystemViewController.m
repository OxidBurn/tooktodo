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


#pragma mark - Internal -

- (void) bindUI
{
    self.systemsTableView.delegate   = self.viewModel;
    self.systemsTableView.dataSource = self.viewModel;
}

#pragma mark - Actions -

- (IBAction) onCancel: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onReady: (id) sender
{
    
}


@end
