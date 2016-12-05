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
#import "OSSecureTextField.h"

#define kOFFSET_FOR_KEYBOARD 80.0

@interface LoginViewController () <RecoveryViewControllerDeledate, UITextFieldDelegate>

// properties

@property (nonatomic, assign) BOOL isAlert;
@property (assign, nonatomic) BOOL isKeyboard;

// Outlets
@property (weak, nonatomic) IBOutlet UITextField       *emailTextField;
@property (weak, nonatomic) IBOutlet OSSecureTextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton          *forgotPassBtn;
@property (weak, nonatomic) IBOutlet UIButton          *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton          *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton          *showHidePassBtn;
@property (weak, nonatomic) IBOutlet UILabel           *emailWarningLable;
@property (weak, nonatomic) IBOutlet UILabel           *passwordWarningLabel;
@property (weak, nonatomic) IBOutlet UIView            *alertView;
@property (weak, nonatomic) IBOutlet UIView            *contentAlertView;
@property (weak, nonatomic) IBOutlet UIImageView       *alertImg;
@property (weak, nonatomic) IBOutlet UILabel           *alertLabel;

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

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailWarningTopConstraintiPad;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailWarningHeightConstraintiPad;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordWarningTopConstraintiPad;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordWarningHeightConstraintiPad;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *passwordViewTopConstraintiPad;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *emailVerticalToLogoConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *forgotPassVerticalToEnterConstraint;

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

- (IBAction) onClosedKeyboardGesture: (UITapGestureRecognizer*) sender;

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

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(keyboardWillShow:)
                                                 name: UIKeyboardWillShowNotification
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(keyboardWillHide:)
                                                 name: UIKeyboardWillHideNotification
                                               object: nil];
}

- (void) viewWillDisappear: (BOOL) animated
{
    [super viewWillDisappear: animated];
    
    // unregister for keyboard notifications while not visible.
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillShowNotification
                                                  object: nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillHideNotification
                                                  object: nil];
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
    
    controller.delegate = self;
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

-(void) keyboardWillShow: (NSNotification*) notification
{
    // Animate the current view out of the way
    
    if (notification.userInfo[UIKeyboardFrameBeginUserInfoKey])
    {
        [self setViewMovedUp: YES];
    }
}

-(void) keyboardWillHide: (NSNotification*) notification
{
    if (notification.userInfo[UIKeyboardFrameEndUserInfoKey])
    {
        [self setViewMovedUp: NO];
    }
}

-(void) setViewMovedUp: (BOOL)                  movedUp
{
    [UIView beginAnimations: nil
                    context: NULL];
    
    [UIView setAnimationDuration: 0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        if (self.isKeyboard == NO)
        {
            self.isKeyboard = YES;
            
            rect.origin.y = -kOFFSET_FOR_KEYBOARD;
            rect.size.height += kOFFSET_FOR_KEYBOARD;
        }
        
    }
    else
    {
        if ( self.isKeyboard == YES)
        {
            rect.origin.y    += kOFFSET_FOR_KEYBOARD;
            rect.size.height -= kOFFSET_FOR_KEYBOARD;
            self.isKeyboard = NO;
        }
    }
    
    [UIView animateWithDuration: 0.3
                     animations: ^{
                         
                         self.view.frame = rect;
                     }];
    
    [UIView commitAnimations];
}



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
    
    self.emailTextField.text = [self.viewModel getStoredEmailValue];
    
    //hidden alerts by default
    self.alertView.hidden           = YES;
    self.contentAlertView.hidden    = YES;
    
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
            
            [self failedLogin];
            
        }
        
        if (IS_PHONE)
        {
        [[self.viewModel emailWarningMessage] subscribeNext: ^(NSString* emailWarning) {
            
            self.emailWarningLable.text                = emailWarning;
            self.emailWarningLable.hidden              = (emailWarning.length == 0);
            
            self.distanceBeforeEmail.constant          = (emailWarning.length == 0) ? 0  : 5;
            self.emailWarningHeightConstraint.constant = (emailWarning.length == 0) ? 5  : 12;
            self.distanceBeforePassword.constant       = (emailWarning.length == 0) ? 0  : 5;
            self.forgotBtnTopConstraint.constant       = (emailWarning.length == 0) ? 40 : 25;
            
        }];
        
        [[self.viewModel passwordWarningMessage] subscribeNext: ^(NSString* passWarning) {
            
            self.passwordWarningLabel.text                = passWarning;
            self.passwordWarningLabel.hidden              = (passWarning.length == 0);
            
            self.passwordWarningHeightConstraint.constant = (passWarning.length == 0) ? 5  : 12;
            self.passwordWarningTopConstraint.constant    = (passWarning.length == 0) ? 0  : 5;
            self.forgotBtnTopConstraint.constant          = (passWarning.length == 0) ? 40 : 25;
            
        }];
        }
        else
        {
            [[self.viewModel emailWarningMessage] subscribeNext: ^(NSString* emailWarning) {
                
                self.emailWarningLable.text                = emailWarning;
                self.emailWarningLable.hidden              = (emailWarning.length == 0);
                
                self.emailWarningTopConstraintiPad.constant    = (emailWarning.length == 0) ? 0  : 5;
                self.emailWarningHeightConstraintiPad.constant = (emailWarning.length == 0) ? 5  : 12;
                self.passwordViewTopConstraintiPad.constant    = (emailWarning.length == 0) ? 0  : 0;
                self.forgotBtnTopConstraint.constant           = (emailWarning.length == 0) ? 40 : 25;
                
            }];
            
            [[self.viewModel passwordWarningMessage] subscribeNext: ^(NSString* passWarning) {
                
                self.passwordWarningLabel.text                    = passWarning;
                self.passwordWarningLabel.hidden                  = (passWarning.length == 0);

                self.passwordWarningHeightConstraintiPad.constant = (passWarning.length == 0) ? 5  : 12;
                self.passwordWarningTopConstraintiPad.constant    = (passWarning.length == 0) ? 0  : 5;
                self.forgotBtnTopConstraint.constant              = (passWarning.length == 0) ? 40 : 25;
                
            }];
        }
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
            
            if (self.isKeyboard == YES)
            {
                [self setViewMovedUp: NO];
            }
            
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
            [Utils showErrorAlertWithMessage: @"Обранужена проблема с соединением к интернету. Проверьте пожалуйста подключение."];
        }
        
    }];
}


- (void) successLogin
{
    if ( self.dismissLoginView )
        self.dismissLoginView();
    
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

- (void) failedLogin
{
    [self customizeErrorAlert];
    
    [self animateLoginAlert];
    
}


#pragma mark - Actions -

- (IBAction) onToggleShowPass: (UIButton*) sender
{
    [self.passwordTextField updateSecureState: sender.selected];
    
    sender.selected = !sender.selected;
}

- (IBAction) onClosedKeyboardGesture: (UITapGestureRecognizer*) sender
{
    [self.view endEditing: YES];
}


#pragma mark - Helpers -

- (void) customizeErrorAlert
{
   
    self.alertView.backgroundColor = [UIColor colorWithRed: 1.f
                                                     green: 0.317f
                                                      blue: 0.305f
                                                     alpha: 1];
    
    self.contentAlertView.backgroundColor = [UIColor colorWithRed: 1.f
                                                            green: 0.317f
                                                             blue: 0.305f
                                                            alpha: 1];
    
    self.alertImg.image = [UIImage imageNamed: @"errorLoginIcon"];
    self.alertLabel.text = @"Вы указали неверный пароль или адрес электронной почты, попробуйте еще раз.";

}

- (void) customizeSuccessRestoreAlert
{
   
    self.alertView.backgroundColor = [UIColor colorWithRed: 0.309f
                                                     green: 0.77f
                                                      blue: 0.176f
                                                     alpha: 1];
    
    self.contentAlertView.backgroundColor = [UIColor colorWithRed: 0.309f
                                                            green: 0.77f
                                                             blue: 0.176f
                                                            alpha: 1];
    

    self.alertImg.image  = [UIImage imageNamed: @"successRestoreIcon"];
}

- (void) animateLoginAlert
{
    CGRect alertViewFrame = self.alertView.frame;
    
    CGFloat positionY = self.isKeyboard ? 80 : 0;
    
    alertViewFrame.origin.y = positionY;
    
    self.alertView.frame = alertViewFrame;
    
    [UIView animateWithDuration: 0.5
                     animations: ^{
                         
                         self.alertView.hidden        = NO;
                         self.contentAlertView.hidden = NO;
                         
                         [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelStatusBar+1];
                         
                     }
                     completion:^(BOOL finished) {
                         
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             
                             // Hide alert and dismiss login
                             [UIView animateWithDuration: 0.5
                                              animations:^{
                                                  
                                                  // Hide animation of the error alert
                                                  self.alertView.hidden        = YES;
                                                  self.contentAlertView.hidden = YES;
                                                  
                                                  [[[[UIApplication sharedApplication] delegate] window] setWindowLevel:UIWindowLevelNormal];
                                              }
                                              completion: nil];
                             
                         });
                         
                     }];
}


#pragma mark - RecoverViewControllerDelegate methods -

- (void) showSuccessRestoreAlert: (NSString*) text
{
     self.alertLabel.text = text;
    
    [self customizeSuccessRestoreAlert];
    
    [self animateLoginAlert];

}


#pragma mark - Text field delegate -

- (BOOL) textFieldShouldReturn: (UITextField*) textField
{
    [textField resignFirstResponder];
    
    return NO;
}

- (void) textFieldDidBeginEditing: (UITextField*) sender
{
    if ([sender isEqual: self.passwordTextField])
    {
        //move the main view, so that the keyboard does not hide it.
        if  (self.view.frame.origin.y >= 0)
        {
            [self setViewMovedUp: YES];
        }
    }
}

- (void) textFieldDidEndEditing: (UITextField*) textField
{
    [textField resignFirstResponder];
}


#pragma mark - Trait collection -

- (void) traitCollectionDidChange: (UITraitCollection *) previousTraitCollection
{
    [super traitCollectionDidChange: previousTraitCollection ];
    
    if ( (self.traitCollection.verticalSizeClass != previousTraitCollection.verticalSizeClass)
        || (self.traitCollection.horizontalSizeClass != previousTraitCollection.horizontalSizeClass) )
    {
        CGFloat height = self.view.window.frame.size.height;
        
        if ( height > 600 )
        {
            self.emailVerticalToLogoConstraint.constant       = 58.f;
            self.forgotPassVerticalToEnterConstraint.constant = 41.f;
        }
    }
}


@end
