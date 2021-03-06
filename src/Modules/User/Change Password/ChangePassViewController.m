//
//  ChangePassViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ChangePassViewController.h"
#import "ChangePasswordViewModel.h"

// Frameworks
#import "ReactiveCocoa.h"

// Classes
#import "OSSecureTextField.h"

@interface ChangePassViewController ()

// properties
@property (weak, nonatomic) IBOutlet UILabel           *updatedPassWarnings;
@property (weak, nonatomic) IBOutlet OSSecureTextField *oldPasswordField;
@property (weak, nonatomic) IBOutlet OSSecureTextField *updatedPasswordField;
@property (weak, nonatomic) IBOutlet OSSecureTextField *confirmPasswordField;

@property (weak, nonatomic) IBOutlet UIButton *updatePasswordBtn;

@property (strong, nonatomic) ChangePasswordViewModel* viewModel;

// methods
- (IBAction) onDismiss: (UIBarButtonItem*) sender;

@end

@implementation ChangePassViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self bindingUI];
    
    [self titleLabel];
}

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

- (ChangePasswordViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [ChangePasswordViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    self.viewModel.oldPasswordSignal     = self.oldPasswordField.rac_textSignal;
    self.viewModel.updatedPasswordSignal = self.updatedPasswordField.rac_textSignal;
    self.viewModel.confirmPasswordSignal = self.confirmPasswordField.rac_textSignal;
    self.updatePasswordBtn.rac_command   = self.viewModel.changePassCommand;
    RAC(self.updatedPassWarnings, text)  = self.viewModel.updatePasswordWarningMessage;
    
    [self handleModelActions];
}

- (UILabel*) titleLabel
{
    UIFont* customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                         size: 14.0f];
    
    UILabel *label        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 18)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines   = 1;
    label.font            = customFont;
    label.textAlignment   = NSTextAlignmentCenter;
    label.textColor       = [UIColor whiteColor];
    label.text            = @"ИЗМЕНИТЬ ПАРОЛЬ";
    
    [label sizeToFit];
    
    
    
    self.navigationItem.titleView = label;
    
    return label;
}

#pragma mark - Actions -

- (IBAction) onShowPassword: (UIButton*) sender
{
    [self.oldPasswordField updateSecureState: sender.selected];
    
    sender.selected = !sender.selected;
}

- (IBAction) onShowNewPassword: (UIButton*) sender
{
    [self.updatedPasswordField updateSecureState: sender.selected];
    
    sender.selected = !sender.selected;
}

- (IBAction) onShowConfirmPassword: (UIButton*) sender
{
    [self.confirmPasswordField updateSecureState: sender.selected];
    
    sender.selected = !sender.selected;
}

- (void) handleModelActions
{
    @weakify(self)
    
    [self.updatePasswordBtn.rac_command.errors subscribeNext: ^(NSError* error) {
        
        @strongify(self)
        
        if ( error.code == 101 )
        {
            self.updatedPassWarnings.hidden = NO;
        }
        
    }];
    
    [self.updatePasswordBtn.rac_command.executionSignals subscribeNext: ^(RACSignal* signal) {
       
        @strongify(self)
        
        [signal subscribeNext: ^(id x) {
            
            if ( x )
            {
                self.updatedPassWarnings.hidden = YES;
                
                [SVProgressHUD showSuccessWithStatus: @"Пароль успешно обновлен"];
                
                [self.navigationController popViewControllerAnimated: YES];
            }
            
        }];
        
    }];
}

- (IBAction) onDismiss: (UIBarButtonItem*) sender
{    
    [self.navigationController popViewControllerAnimated: YES];
}

@end
