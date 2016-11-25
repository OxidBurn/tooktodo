//
//  ApproverViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ApproverViewController.h"

//Classes
#import "ApproverViewModel.h"

@interface ApproverViewController ()

// Properties

@property (weak, nonatomic) IBOutlet UITableView *approverTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;

@property (nonatomic, strong) ApproverViewModel* viewModel;

// Methods
- (IBAction) onDone: (UIBarButtonItem*) sender;

- (IBAction) onBackBtn: (UIBarButtonItem*) sender;

@end

@implementation ApproverViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    self.approverTableView.delegate   = self.viewModel;
    self.approverTableView.dataSource = self.viewModel;
}


#pragma mark - Properties -

- (ApproverViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [ApproverViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Public -



#pragma mark - Actions -

- (IBAction) onDone: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}
@end
