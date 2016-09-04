//
//  RoleInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RoleInfoViewController.h"
#import "RoleInfoViewModel.h"

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


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (RoleInfoViewModel *)viewModel
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

@end
