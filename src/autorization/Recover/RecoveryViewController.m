//
//  RecoveryViewController.m
//  TookTODO
//
//  Created by Глеб on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <ReactiveCocoa.h>

// Classes
#import "RecoveryViewController.h"
#import "RecoverySuccessViewController.h"

@interface RecoveryViewController()

// properties

// Outlets
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton    *resetPassBtn;
@property (weak, nonatomic) IBOutlet UIButton    *registerBtn;

@property (strong, nonatomic) RecoveryViewModel* viewModel;

// methods

- (void) bindingUI;

- (void) handleModelOperations;

@end

@implementation RecoveryViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Binding ui components with model
    [self bindingUI];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Segue -

- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    [super prepareForSegue: segue
                    sender: sender];
    
    RecoverySuccessViewController* controller = segue.destinationViewController;
    
    [controller setViewModel: self.viewModel];
}


#pragma mark - Public methods -

- (void) setRecoveryModel: (RecoveryViewModel*) model
{
    self.viewModel = model;
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    // default value of the email field
    self.emailField.text = self.viewModel.emailValue;
    
    // binding
    RAC(self.viewModel, emailValue) = self.emailField.rac_textSignal;
    self.resetPassBtn.rac_command   = self.viewModel.resetPassCommand;
    self.registerBtn.rac_command    = self.viewModel.registerCommand;
    
    [self handleModelOperations];
}


#pragma mark - Handled model operations -

- (void) handleModelOperations
{
    @weakify(self)
    
    [self.viewModel.resetPassCommand.executionSignals subscribeNext: ^(RACSignal* signal) {
        
        [signal subscribeNext: ^(id x) {
            
            @strongify(self)
            
            [self performSegueWithIdentifier: @"ShowSuccessResetingPassInfoID"
                                      sender: self];
            
        }
                    completed: ^{
                        
                    }];
        
    }];
    
    [self.viewModel.resetPassCommand.errors subscribeNext: ^(id x) {
        
        [[self.viewModel emailWarningMessage] subscribeNext: ^(NSString* emailWarning) {
            
            NSLog(@"Email warning message %@", emailWarning);
            
        }];
        
    }];
}

@end
