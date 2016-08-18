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

@interface ChangePassViewController ()

@property (weak, nonatomic) IBOutlet UILabel     *updatedPassWarnings;

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *updatedPasswordField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordField;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *updatePasswordBtn;
@end

@implementation ChangePassViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self bindingUI];
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


#pragma mark - Internal methods -

- (void) bindingUI
{
    
}


#pragma mark - Actions -



@end
