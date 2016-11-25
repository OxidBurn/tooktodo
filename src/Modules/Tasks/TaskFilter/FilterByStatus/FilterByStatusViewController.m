//
//  FilterByStatusViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 25.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByStatusViewController.h"

// Classes
#import "FilterByStatusViewModel.h"

@interface FilterByStatusViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UITableView* filterByStatusTableView;

// properties
@property (strong, nonatomic) FilterByStatusViewModel* viewModel;

// methods
- (IBAction) onBackBtn: (UIBarButtonItem*) sender;

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender;

@end

@implementation FilterByStatusViewController


#pragma mark - Lyfe cycle -

- (void) loadView
{
    [super loadView];
    
    [self setupDefaults];
}


#pragma mark - Properties -

- (FilterByStatusViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [FilterByStatusViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Actions -

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    if ( [self.delegate respondsToSelector:@selector(returnSelectedStatusesArray:)] )
    {
        [self.delegate returnSelectedStatusesArray: [self.viewModel getSelectedStatusesArray]];
    }
    
    [self.navigationController popViewControllerAnimated: YES];
}


#pragma mark - Public -

- (void) fillDelegate: (id) deletate
{
    self.delegate = deletate;
}



#pragma mark - Internal -

- (void) setupDefaults
{
    self.filterByStatusTableView.dataSource = self.viewModel;
    self.filterByStatusTableView.delegate   = self.viewModel;
}

@end
