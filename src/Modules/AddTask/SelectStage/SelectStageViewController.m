//
//  SelectStageViewController.m
//  TookTODO
//
// Created by Nikolay Chaban on 30.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectStageViewController.h"

//Classes
#import "SelectStageViewModel.h"
#import "ProjectTaskStage+CoreDataClass.h"

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


#pragma mark - Public -

- (void) fillSelectedStage: (ProjectTaskStage*)                      stage
              withDelegate: (id <SelectStageViewControllerDelegate>) delegate
{
    [self.viewModel fillSelectedStage: stage];
    
    self.delegate = delegate;
}


#pragma mark - Internal -

- (void) bindUI
{
    self.stagesTableView.delegate   = self.viewModel;
    self.stagesTableView.dataSource = self.viewModel;
}

- (void) saveData
{
    ProjectTaskStage* selectedStage = [self.viewModel getSelectedStage];
    
    if ( [self.delegate respondsToSelector: @selector(returnSelectedStage:)] )
    {
        [self.delegate returnSelectedStage: selectedStage];
        
        [self.navigationController popViewControllerAnimated: YES];
    }
}

#pragma mark - Actions -

- (IBAction) onCancel: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onReady: (id) sender
{
    [self saveData];
}


@end
