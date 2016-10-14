//
//  AddNewRoleViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 10/13/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddNewRoleViewController.h"

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "AddNewRoleViewModel.h"

@interface AddNewRoleViewController ()

// properties

@property (weak, nonatomic) IBOutlet UITextField* roleTitleTextField;

@property (strong, nonatomic) AddNewRoleViewModel* viewModel;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *createNewRoleBtn;

// methods

- (IBAction) onDismiss: (UIBarButtonItem*) sender;

@end

@implementation AddNewRoleViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // binding UI with model
    [self bindingUI];
    
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (AddNewRoleViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [AddNewRoleViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    RAC(self.viewModel, roleTitle)    = self.roleTitleTextField.rac_textSignal;
    self.createNewRoleBtn.rac_command = [self.viewModel createNewRoleCommand];
}


#pragma mark - Actions -

- (IBAction) onDismiss: (UIBarButtonItem*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

@end
