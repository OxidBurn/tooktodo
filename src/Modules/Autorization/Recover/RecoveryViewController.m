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
#import "LoginViewController.h"

@interface RecoveryViewController()

// properties

// Outlets
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UIButton    *resetPassBtn;
@property (weak, nonatomic) IBOutlet UIButton    *registerBtn;
@property (weak, nonatomic) IBOutlet UILabel *warningLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailWarningHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailWarningTopConstraint;


@property (strong, nonatomic) RecoveryViewModel* viewModel;

// methods

- (void) bindingUI;

- (void) handleModelOperations;

- (IBAction) onDismiss: (UIButton*) sender;
- (IBAction) onHideKeyboard: (UITapGestureRecognizer*) sender;

@end

@implementation RecoveryViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
   NSLog(@"Navigation controller %@", self.navigationController); 
    
    // Binding ui components with model
    [self bindingUI];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties -



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
    
    //
   // self.viewModel.delegate = self;
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
                
                
                if ([self.delegate respondsToSelector:@selector(showSuccessRestoreAlert:)])
                {
                    [self.delegate showSuccessRestoreAlert: [self.viewModel getSuccessRestorePassLabel]];
                }
                
                [self dismissViewControllerAnimated: YES
                                         completion: nil];
                
            }

    }];
    }];
    
    [self.resetPassBtn.rac_command.errors subscribeNext: ^(NSError* error) {
        
        if ( error.code == -1011 )
        {
            [Utils showErrorAlertWithMessage: @"Логин (электронная почта) не зарегистрирован"];
        }
        
        [[self.viewModel emailWarningMessage] subscribeNext: ^(NSString* emailWarning) {
            
            self.warningLabel.text                     = emailWarning;
            self.warningLabel.hidden                   = (emailWarning.length == 0);
            self.emailWarningHeightConstraint.constant = (emailWarning.length == 0) ? 5 : 12;
            self.emailWarningTopConstraint.constant    = (emailWarning.length == 0) ? 0 : 5;
            
            NSLog(@"Email warning message %@", emailWarning);
            
        }];
        
    }];
}

- (IBAction) onDismiss: (UIButton*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

- (IBAction) onHideKeyboard: (UITapGestureRecognizer*) sender
{
    [self.view endEditing: YES];
}

- (void) handleInternetConnection
{
    [[Reachability rac_reachabilitySignal] subscribeNext: ^(Reachability *reach) {
        
        if ( [reach isReachable] == NO )
        {
            [Utils showErrorAlertWithMessage: @"Обранужена проблема с соединением к интернету.\nПроверьте пожалуйста подключение."];
        }
        
    }];
}

@end
