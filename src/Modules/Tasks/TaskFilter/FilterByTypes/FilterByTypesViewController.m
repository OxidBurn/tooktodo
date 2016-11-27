//
//  FilterByTypesViewController.m
//  TookTODO
//
//  Created by Lera on 27.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterByTypesViewController.h"

//Classes
#import "FilterByTypesViewModel.h"
#import "TaskFilterConfiguration.h"

@interface FilterByTypesViewController ()

//Outlets
@property (nonatomic, weak) IBOutlet UITableView* typesTableView;

//Properties
@property (nonatomic, strong) FilterByTypesViewModel* viewModel;

// Methods
- (IBAction) onBackBtn: (UIBarButtonItem*) sender;

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender;

@end

@implementation FilterByTypesViewController


#pragma mark - Life cycle -

-(void) loadView
{
    [super loadView];
    
    self.typesTableView.dataSource = self.viewModel;
    self.typesTableView.delegate   = self.viewModel;
}

#pragma mark - Properties -

- (FilterByTypesViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [FilterByTypesViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Public -

- (void) fillSelectedTypesInfoFromConfig: (TaskFilterConfiguration*) filterConfig
{
    [self.viewModel fillSelectedTypesInfoFromConfig: filterConfig];
}

#pragma mark - Actions -

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    if ([self.delegate respondsToSelector: @selector(returnSelectedTypesArray:)])
    {
        [self.delegate returnSelectedTypesArray: [self.viewModel getSelectedTypesArray]];
    }
    
    [self.navigationController popViewControllerAnimated: YES];

}

@end
