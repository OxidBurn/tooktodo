//
//  ViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/8/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "LoginViewController.h"
#import "LoginViewModel.h"

// Frameworks
#import "ReactiveCocoa.h"

@interface LoginViewController ()

// properties

// Outlets
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton    *forgotPassBtn;
@property (weak, nonatomic) IBOutlet UIButton    *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton    *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel     *emailWarningLable;
@property (weak, nonatomic) IBOutlet UILabel     *passwordWarningLabel;

@property (strong, nonatomic) LoginViewModel* viewModel;

// methods

/**
 *  Method for binding all UI components with view model
 */
- (void) bindingUI;


@end

@implementation LoginViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Hide unnecessary navigation bar
    self.navigationController.navigationBar.hidden = YES;
    
    // binding all UI components
    [self bindingUI];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void) bindingUI
{
    RAC(self.viewModel, emailValue)    = [self.emailTextField.rac_textSignal distinctUntilChanged];
    RAC(self.viewModel, passwordValue) = [self.passwordTextField.rac_textSignal distinctUntilChanged];
    self.loginBtn.rac_command          = self.viewModel.excludeLogin;
    self.forgotPassBtn.rac_command     = self.viewModel.excludeForgotPass;
    self.registerBtn.rac_command       = self.viewModel.excludeRegistration;
}

@end
