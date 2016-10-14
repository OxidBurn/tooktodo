//
//  ChangeStatusViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ChangeStatusViewController.h"

//Classes
#import "ChangeStatusViewModel.h"
#import "TaskDetailViewController.h"

@interface ChangeStatusViewController ()

// outlets
@property (weak, nonatomic) IBOutlet UITableView*     statusesTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* backBtn;
@property (weak, nonatomic) IBOutlet UIImageView*     expandedArrowMarkImageView;

// properties
@property (nonatomic, strong) ChangeStatusViewModel* viewModel;

// methods
- (IBAction) onBack: (UIBarButtonItem*) sender;

@end

@implementation ChangeStatusViewController


#pragma mark - LifeCycle -

- (void) loadView
{
    [super loadView];
    
    [self setupDefaults];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
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

#pragma mark - Actions -

- (IBAction) onBack: (UIBarButtonItem*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

#pragma mark - Helpers -

- (void) setupDefaults
{
    self.statusesTableView.dataSource = self.viewModel;
    self.statusesTableView.delegate   = self.viewModel;
    
    self.navigationController.navigationBar.backItem.title = @"Назад";
    
    [self updateArrowMarkImage];
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.showOnRevisionController = ^(){
        
        [blockSelf dismissViewControllerAnimated: NO
                                      completion: ^{
                                          
                                          if ([blockSelf.delegate respondsToSelector:@selector(performSegueWithID:)])
                                          {
                                              [blockSelf.delegate performSegueWithID: @"ShowOnRevisionController"];
                                          }
                                      }];
    };
    
    self.viewModel.returnToTaskDetailController = ^(){
        
        if ( [blockSelf.delegate respondsToSelector: @selector(updataTaskDetailInfoTaskStatus)] )
            [blockSelf.delegate updataTaskDetailInfoTaskStatus];
        
        [blockSelf dismissViewControllerAnimated: YES
                                      completion: nil];
    };
}

- (void) updateArrowMarkImage
{
    self.expandedArrowMarkImageView.image = [self.viewModel getExpandedArrowMarkImage];
}

@end
