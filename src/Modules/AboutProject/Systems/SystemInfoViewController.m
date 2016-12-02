//
//  SystemInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SystemInfoViewController.h"

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "SystemsInfoViewModel.h"

// Categories
#import "UIViewController+Focus.h"

@interface SystemInfoViewController ()

// properties

@property (weak, nonatomic) IBOutlet UITableView* systemInfoTableView;

@property (strong, nonatomic) SystemsInfoViewModel* viewModel;

@property (strong, nonatomic) UIRefreshControl* refreshControl;

// methods

- (void) setupUI;

- (void) bindingUI;

- (void) updateInfo;

@end

@implementation SystemInfoViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup UI components
    [self setupUI];
    
    // Binding UI with model
    [self bindingUI];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    // Update systems info before screen is appeared and reload info table
    [self updateInfo];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (SystemsInfoViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [[SystemsInfoViewModel alloc] init];
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) setupUI
{
    self.refreshControl = [[UIRefreshControl alloc] init];
    
    self.refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString: @"Обновить"];
    
    [self.refreshControl addTarget: self
                            action: @selector(updateContent)
                  forControlEvents: UIControlEventValueChanged];
    
    [self.systemInfoTableView addSubview: self.refreshControl];
}

- (void) bindingUI
{
    self.systemInfoTableView.dataSource     = self.viewModel;
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
        
        [self.systemInfoTableView reloadData];
        
    }];
}

- (void) updateContent
{
    [self updateInfo];
    
    [self.refreshControl endRefreshing];
}

@end
