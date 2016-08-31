//
//  UpdateInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UpdateInfoViewController.h"
#import "UpdateInfoViewModel.h"

// Frameworks
#import "ReactiveCocoa.h"
#import "UITextField+AKNumericFormatter.h"

@interface UpdateInfoViewController ()

// properties

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *surnameField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;
@property (weak, nonatomic) IBOutlet UITextField *additionalPhoneNumberField;
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;

@property (nonatomic, strong) UpdateInfoViewModel* viewModel;
@end

@implementation UpdateInfoViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self updateValues];
    
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

- (UpdateInfoViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [UpdateInfoViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    RAC(self.viewModel, userName)                  = self.nameField.rac_textSignal;
    RAC(self.viewModel, userSurname)               = self.surnameField.rac_textSignal;
    RAC(self.viewModel, userPhoneNumber)           = self.phoneNumberField.rac_textSignal;
    RAC(self.viewModel, userAdditionalPhoneNumber) = self.additionalPhoneNumberField.rac_textSignal;
    
    // Field formats
    self.phoneNumberField.numericFormatter           = [self.viewModel getPhoneNumberFormat];
    self.additionalPhoneNumberField.numericFormatter = [self.viewModel getPhoneNumberFormat];
    
    // commands
    self.doneBtn.rac_command = self.viewModel.saveDataCommand;
    
    [self handleActions];
    
}

- (void) updateValues
{
    self.nameField.text                  = self.viewModel.userName;
    self.surnameField.text               = self.viewModel.userSurname;
    self.phoneNumberField.text           = self.viewModel.userPhoneNumber;
    self.additionalPhoneNumberField.text = self.viewModel.userAdditionalPhoneNumber;
}

- (void) handleActions
{
    @weakify(self)
    
    [self.doneBtn.rac_command.executionSignals subscribeNext: ^(RACSignal* signal) {
       
        [signal subscribeNext: ^(id x) {
           
            @strongify(self)
            
            [self.navigationController popViewControllerAnimated: YES];
            
        }];
        
    }];
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
    label.text            = @"ПРОФИЛЬ";

    [label sizeToFit];
    
    
    
    self.navigationItem.titleView = label;
    
    return label;
}

- (IBAction)onCancel:(UIButton *)sender {
    
    [self.navigationController popViewControllerAnimated: YES];
}

@end
