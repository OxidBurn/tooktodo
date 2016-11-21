//
//  OSAlertDeleteTast.m
//  TookTODO
//
//  Created by Nikolay Chaban on 08.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertDeleteTaskWithSubtasksController.h"
#import "OSAlertDeleteTaskWithSubtasksViewModel.h"


@interface OSAlertDeleteTaskWithSubtasksController ()

@property (weak, nonatomic) IBOutlet UITableView *contentTable;

@property (nonatomic, strong) OSAlertDeleteTaskWithSubtasksViewModel* viewModel;

@end

@implementation OSAlertDeleteTaskWithSubtasksController


- (void) loadView
{
    [super loadView];
    
    self.contentTable.delegate   = self.viewModel;
    self.contentTable.dataSource = self.viewModel;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.dismissAlert = ^() {
        
        [self dismissViewControllerAnimated: YES
                                 completion: nil];
    };
}

- (OSAlertDeleteTaskWithSubtasksViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [OSAlertDeleteTaskWithSubtasksViewModel new];
       // _viewModel.delegate  = self;
    }
    
    return _viewModel;
}


@end
