//
//  SelectTaskTypeViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskTypeViewController.h"

// Classes
#import "AddTaskTypeViewModel.h"

@interface AddTaskTypeViewController ()

// properties

@property (strong, nonatomic) AddTaskTypeViewModel* viewModel;

@property (weak, nonatomic) IBOutlet UITableView *taskTypesTableView;

// methods

- (IBAction) onDone: (UIBarButtonItem*) sender;

- (IBAction) onCancel: (UIBarButtonItem*) sender;

- (IBAction) onSave: (UIButton*) sender;

@end

@implementation AddTaskTypeViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    // Do any additional setup after loading the view.
    
    [self bindingUI];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (AddTaskTypeViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [AddTaskTypeViewModel new];
        
#warning 'Только для тестирование, удалить после реализации метода fillSelectedTaskType'
        [_viewModel fillSavedTaskType: 0];
    }
    
    return _viewModel;
}


#pragma mark - Public methods -

- (void) fillSelectedTaskType: (TaskType) type
{
    [self.viewModel fillSavedTaskType: type];
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    self.taskTypesTableView.dataSource = self.viewModel;
    self.taskTypesTableView.delegate   = self.viewModel;
}

- (void) returnNewTaskTypeInfo
{
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel getSelectedInfo: ^(NSString *taskTypeDescription, TaskType type) {
        
        if ( [blockSelf.delegate respondsToSelector: @selector(didSelectedTaskType:withDescription:)] )
        {
            [blockSelf.delegate didSelectedTaskType: type
                                    withDescription: taskTypeDescription];
        }
        
        [blockSelf.navigationController popViewControllerAnimated: YES];
        
    }];
}

#pragma mark - Actions -

- (IBAction) onDone: (UIBarButtonItem*) sender
{
    [self returnNewTaskTypeInfo];
}

- (IBAction) onCancel: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onSave: (UIButton*) sender
{
    [self returnNewTaskTypeInfo];
}



@end
