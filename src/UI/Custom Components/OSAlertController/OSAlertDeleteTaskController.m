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

- (void) handleAlertActions;

@end

@implementation OSAlertDeleteTaskWithSubtasksController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    self.contentTable.delegate   = self.viewModel;
    self.contentTable.dataSource = self.viewModel;
    
    // handle actions from table view
    [self handleAlertActions];
}


#pragma mark - Property -

- (OSAlertDeleteTaskWithSubtasksViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [OSAlertDeleteTaskWithSubtasksViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) handleAlertActions
{
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.dismissAlert = ^() {
        
        [blockSelf dismissViewControllerAnimated: YES
                                      completion: nil];
    };
    
    
    self.viewModel.deleteTaskWithSubtasks = ^(BOOL withSubtasks){
        
        if ( [blockSelf.delegate respondsToSelector: @selector(deleteTaskWithSubtasks:)] )
            [blockSelf.delegate deleteTaskWithSubtasks: withSubtasks];
        
    };
}

@end
