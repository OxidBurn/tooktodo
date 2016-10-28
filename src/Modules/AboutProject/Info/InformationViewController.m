//
//  InformationInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "InformationViewController.h"

// Classes
#import "InformationViewModel.h"

// Categories
#import "UIViewController+Focus.h"
#import "BaseMainViewController+NavigationTitle.h"

@interface InformationViewController ()

// properties

@property (weak, nonatomic) IBOutlet UITableView* informationTableView;

@property (nonatomic, strong)  InformationViewModel* viewModel;

// methods

@end

@implementation InformationViewController

#pragma mark - Properties -

- (InformationViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [[InformationViewModel alloc] init];
    }
    
    return _viewModel;
}

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    self.informationTableView.dataSource = self.viewModel;
    self.informationTableView.delegate   = self.viewModel;
    
    // Setup navigation
    if ( self.navigationController )
        [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ИНФОРМАЦИЯ"
                                                   withSubTitle: nil];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    [self.viewModel updateProjectInfo];
    
    [self.informationTableView reloadData];
}


#pragma mark - Internal methods -

- (void) needToUpdateContent
{
    [self.viewModel updateProjectInfo];
    
    [self.informationTableView reloadData];
}

@end
