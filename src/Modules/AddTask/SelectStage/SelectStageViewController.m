//
//  SelectStageViewController.m
//  TookTODO
//
//  Created by Lera on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectStageViewController.h"

//Classes
#import "SelectStageViewModel.h"

@interface SelectStageViewController ()

// Outlets

@property (weak, nonatomic) IBOutlet UITableView *stagesTableView;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *readyBtn;

// Properties

@property (nonatomic, strong) SelectStageViewModel* viewModel;

@end

@implementation SelectStageViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self bindUI];
}

#pragma mark - Properties -

- (SelectStageViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [SelectStageViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Internal -

- (void) bindUI
{
    self.stagesTableView.delegate   = self.viewModel;
    self.stagesTableView.dataSource = self.viewModel;
}

@end
