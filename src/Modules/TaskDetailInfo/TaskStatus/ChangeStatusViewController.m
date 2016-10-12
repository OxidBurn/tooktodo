//
//  ChangeStatusViewController.m
//  TookTODO
//
//  Created by Lera on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ChangeStatusViewController.h"

//Classes
#import "ChangeStatusViewModel.h"
#import "TaskDetailViewController.h"

@interface ChangeStatusViewController ()

@property (weak, nonatomic) IBOutlet UITableView *statusesTableView;
@property (nonatomic, strong) ChangeStatusViewModel* viewModel;

//Actions

- (IBAction) onBack: (UIBarButtonItem*) sender;

@end

@implementation ChangeStatusViewController


#pragma mark - LifeCycle -

- (void) loadView
{
    [super loadView];
    
    self.statusesTableView.dataSource = self.viewModel;
    self.statusesTableView.delegate   = self.viewModel;
}


#pragma mark - Properties -

- (ChangeStatusViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [ChangeStatusViewModel new];
    }
    
    return _viewModel;
}

#pragma mark - Public -

- (void) fillSelectedStatus: (TaskStatusType) status
{
    [self.viewModel fillSelectedStatusType: status];
}

- (void) getChangedTaskStatusInfo
{
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel getChangedInfo:^(NSString *statusName, TaskStatusType statusType, UIColor *background, UIImage *statusImage) {
        
        if ([blockSelf.delegate respondsToSelector: @selector(didChangedTaskStatus:withName:withImage:withBackGroundColor:)])
        {
            [blockSelf.delegate didChangedTaskStatus: statusType
                                            withName: statusName
                                           withImage: statusImage
                                 withBackGroundColor: background];
        }
        
        [blockSelf dismissViewControllerAnimated: YES
                                      completion: nil];
    }];
}

#pragma mark - Actions -

- (IBAction) onBack: (UIBarButtonItem*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}
@end
