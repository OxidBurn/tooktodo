//
//  RoleInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RoleInfoViewController.h"

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "RoleInfoViewModel.h"

// Categories
#import "UIViewController+Focus.h"

@interface RoleInfoViewController ()

//properties

@property (weak, nonatomic) IBOutlet UITableView* roleInfoTableView;

@property (strong, nonatomic) RoleInfoViewModel* viewModel;

// methods

- (void) bindingUI;

@end

@implementation RoleInfoViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Binding UI with model
    [self bindingUI];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    // Update all info on scree
    [self updateInfo];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (RoleInfoViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [[RoleInfoViewModel alloc] init];
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    self.roleInfoTableView.dataSource = self.viewModel;
    self.roleInfoTableView.delegate   = self.viewModel;
}

- (void) needToUpdateContent
{
    [self updateInfo];
}

- (void) updateInfo
{
    @weakify(self)
    
    [[self.viewModel updateInfo] subscribeNext: ^(id x) {
        
        @strongify(self)
        
        [self.roleInfoTableView reloadData];
        
    }];
}

@end
