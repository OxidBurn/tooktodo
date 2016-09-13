//
//  OSAlertPlanNotLoadedController.m
//  TookTODO
//
//  Created by Lera on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertPlanNotLoadedController.h"
#import "OSAlertPlanNotLoadedViewModel.h"


@interface OSAlertPlanNotLoadedController () <OSAlertPlanNotLoadedViewModelDelegate>

@property (weak, nonatomic) IBOutlet UITableView *contentTable;

@property (nonatomic, strong) OSAlertPlanNotLoadedViewModel* viewModel;

@end

@implementation OSAlertPlanNotLoadedController


#pragma mark - Life Cycle -

- (void) loadView
{
    [super loadView];
    
    self.contentTable.delegate   = self.viewModel;
    self.contentTable.dataSource = self.viewModel;
    
}


#pragma mark - Properties -

- (OSAlertPlanNotLoadedViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [OSAlertPlanNotLoadedViewModel new];
        _viewModel.delegate  = self;
    }
    
    return _viewModel;
}

#pragma mark - OSAlertPlanNotLoadedViewModelDelegate methods -



@end
