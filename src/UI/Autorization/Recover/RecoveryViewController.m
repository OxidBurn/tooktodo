//
//  RecoveryViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "RecoveryViewController.h"
#import "RecoverySuccessViewController.h"

@interface RecoveryViewController()

// properties

// Outlets
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton    *resetPassBtn;
@property (weak, nonatomic) IBOutlet UIButton    *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceBeforeEmail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceToRecoverBtn;

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
    
    [controller setModel: self.viewModel];
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
    self.resetPassBtn.rac_command   = [self.viewModel resetPassCommand];
    self.registerBtn.rac_command    = [self.viewModel registerCommand];
    
    [self handleModelOperations];
    
    [self handleInternetConnection];
}


#pragma mark - Handled model operations -

- (void) handleModelOperations
{
    @weakify(self)
    
    [self.resetPassBtn.rac_command.executionSignals subscribeNext: ^(RACSignal* signal) {
        
        [signal subscribeNext: ^(id x) {

            if ( x )
            {
                @strongify(self)

                [self performSegueWithIdentifier: @"ShowSuccessResetingPassInfoID"
                                          sender: self];
}

    }];
    }];
    
    [self.resetPassBtn.rac_command.errors subscribeNext: ^(NSError* error) {
        
        if ( error.code == -1011 )
        {
            [SVProgressHUD showErrorWithStatus: @"Логин (электронная почта) не зарегистрирован"];
        }
        
        [[self.viewModel emailWarningMessage] subscribeNext: ^(NSString* emailWarning) {
            
            self.warningLabel.text = emailWarning;
            self.warningLabel.hidden = (emailWarning.length == 0);
            self.distanceBeforeEmail.constant = (emailWarning.length == 0) ? 15 : 27;
            self.distanceToRecoverBtn.constant = (emailWarning.length == 0) ? 233 : 221;
            
            NSLog(@"Email warning message %@", emailWarning);
            
        }];
        
    }];
}

- (void) handleInternetConnection
{
    [[Reachability rac_reachabilitySignal] subscribeNext: ^(Reachability *reach) {
        
        if ( [reach isReachable] == NO )
        {
            [SVProgressHUD showErrorWithStatus: @"Обранужена проблема с соединением к интернету.\nПроверьте пожалуйста подключение."];
        }
        
    }];
}

@end
