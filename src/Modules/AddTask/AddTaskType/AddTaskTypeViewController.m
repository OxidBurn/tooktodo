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

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    
}

- (IBAction)onDone:(UIBarButtonItem *)sender {
}

- (IBAction)onCancel:(UIBarButtonItem *)sender {
}

- (IBAction)onSave:(UIButton *)sender {
}
@end
