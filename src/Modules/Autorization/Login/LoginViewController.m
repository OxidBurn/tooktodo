//
//  ViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/8/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "LoginViewController.h"
#import "LoginViewModel.h"
#import "RecoveryViewModel.h"
#import "RecoveryViewController.h"

@interface LoginViewController ()

// properties

// Outlets
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton    *forgotPassBtn;
@property (weak, nonatomic) IBOutlet UIButton    *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton    *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton    *showHidePassBtn;
@property (weak, nonatomic) IBOutlet UILabel     *emailWarningLable;
@property (weak, nonatomic) IBOutlet UILabel     *passwordWarningLabel;

// Models
@property (strong, nonatomic) LoginViewModel    * viewModel;
@property (strong, nonatomic) RecoveryViewModel * recoveryModel;

// Constraints
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceBeforeEmail;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *distanceBeforePassword;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailWarningHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordWarningHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordWarningTopConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *forgotBtnTopConstraint;

// methods

/**
 *  Method for binding all UI components with view model
 */
- (void) bindingUI;

/**
 *  External method for handling model operations for each button
 */
- (void) handleModelOperations;

- (IBAction) onToggleShowPass: (UIButton*) sender;

- (IBAction)onClosedKeyboardGesture:(UITapGestureRecognizer *)sender;

@end

//TODO: Need to improve working app without internet. More stable handling internet conneciton.
@implementation LoginViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup UI defaults value
    [self setupDefaultsValues];
    
    // binding all UI components
    [self bindingUI];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Segue -

- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    [super prepareForSegue: segue
                    sender: sender];
    
    RecoveryViewController* controller = [segue destinationViewController];
    
    [controller setRecoveryModel: self.recoveryModel];
}


#pragma mark - Properties -

- (LoginViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [[LoginViewModel alloc] init];
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) setupDefaultsValues
{
    // Hide unnecessary navigation bar
    self.navigationController.navigationBar.hidden = YES;
    
    // Added image for selected state in show/hide password button
    [self.showHidePassBtn setImage: [UIImage imageNamed: @"closedEyes"]
                          forState: UIControlStateSelected];
}

- (void) bindingUI
{
    RAC(self.viewModel, emailValue)    = [self.emailTextField.rac_textSignal distinctUntilChanged];
    RAC(self.viewModel, passwordValue) = [self.passwordTextField.rac_textSignal distinctUntilChanged];
    
    self.loginBtn.rac_command      = self.viewModel.loginCommand;
    self.forgotPassBtn.rac_command = self.viewModel.restorePassCommand;
    self.registerBtn.rac_command   = self.viewModel.registerCommand;
    
    [self handleModelOperations];
}

- (void) handleModelOperations
{
    [self handleLoginOperations];
    
    [self handleRestorePassOperations];
    
    [self handleInternetConnection];
}



- (void) handleLoginOperations
{
    @weakify(self)
    
    [self.loginBtn.rac_command.errors subscribeNext: ^(NSError* error) {
        
        @strongify(self)
        
        if ( error.code == -1011 )
        {
            [SVProgressHUD showErrorWithStatus: @"Ошибка авторизации\nПара Логин \\ Пароль, не верна"];
        }
        
        [[self.viewModel emailWarningMessage] subscribeNext: ^(NSString* emailWarning) {
            
            self.emailWarningLable.text                = emailWarning;
            self.emailWarningLable.hidden              = (emailWarning.length == 0);
            
            self.distanceBeforeEmail.constant          = (emailWarning.length == 0) ? 0 : 5;
            self.emailWarningHeightConstraint.constant = (emailWarning.length == 0) ? 5 : 12;
            self.distanceBeforePassword.constant       = (emailWarning.length == 0) ? 0 : 5;
            self.forgotBtnTopConstraint.constant       = (emailWarning.length == 0) ? 40 : 25;
            
        }];
        
        [[self.viewModel passwordWarningMessage] subscribeNext: ^(NSString* passWarning) {
            
            self.passwordWarningLabel.text                = passWarning;
            self.passwordWarningLabel.hidden              = (passWarning.length == 0);
            
            self.passwordWarningHeightConstraint.constant = (passWarning.length == 0) ? 5 : 12;
            self.passwordWarningTopConstraint.constant    = (passWarning.length == 0) ? 0 : 5;
            self.forgotBtnTopConstraint.constant          = (passWarning.length == 0) ? 40 : 25;
            
        }];
        
    }];
    
    [self.loginBtn.rac_command.executionSignals subscribeNext: ^(RACSignal* signal) {
        
        [signal subscribeNext: ^(id x) {
            
            @strongify(self)
            
            if ( x )
            {
                [self successLogin];
            }
            
        }];
        
    }];
}

- (void) handleRestorePassOperations
{
    @weakify(self)
    
    [self.forgotPassBtn.rac_command.executionSignals subscribeNext: ^(RACSignal* signal) {
        
        [signal subscribeNext: ^(id x) {
            
            @strongify(self)
            
            self.recoveryModel = x;
            
            [self performSegueWithIdentifier: @"ShowResetingPassScreenID"
                                      sender: self];
            
        }];
        
        [signal subscribeCompleted:^{
            
            NSLog(@"Reset completed!");
            
        }];
        
        
    }];
}


- (void) handleInternetConnection
{
    [[Reachability rac_reachabilitySignal] subscribeNext: ^(Reachability *reach) {
        
        if ( [reach isReachable] == NO )
        {
            [SVProgressHUD showErrorWithStatus: @"Обранужена проблема с соединением к интернету. Проверьте пожалуйста подключение."];
        }
        
    }];
}


#pragma mark - Actions -

- (IBAction) onToggleShowPass: (UIButton*) sender
{
    [self.passwordTextField resignFirstResponder];
    self.passwordTextField.secureTextEntry = sender.selected;
    [self.passwordTextField becomeFirstResponder];
    
    sender.selected = !sender.selected;
}

- (IBAction)onClosedKeyboardGesture:(UITapGestureRecognizer *)sender {
}

- (void) successLogin
{
    if ( self.dismissLoginView )
        self.dismissLoginView();
    
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

@end
