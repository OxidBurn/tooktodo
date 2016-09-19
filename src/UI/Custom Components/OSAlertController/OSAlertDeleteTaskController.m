//
//  OSAlertDeleteTast.m
//  TookTODO
//
//  Created by Lera on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertDeleteTaskController.h"
#import "OSAlertDeleteTaskViewModel.h"


@interface OSAlertDeleteTaskController ()

@property (weak, nonatomic) IBOutlet UITableView *contentTable;

@property (nonatomic, strong) OSAlertDeleteTaskViewModel* viewModel;

@end

@implementation OSAlertDeleteTaskController


- (void) loadView
{
    [super loadView];
    
    self.contentTable.delegate   = self.viewModel;
    self.contentTable.dataSource = self.viewModel;
    
}

- (OSAlertDeleteTaskViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [OSAlertDeleteTaskViewModel new];
       // _viewModel.delegate  = self;
    }
    
    return _viewModel;
}


@end
