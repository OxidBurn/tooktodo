//
//  RecoverySuccessViewController.m
//  TookTODO
//
//  Created by Глеб on 09.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RecoverySuccessViewController.h"
#import "RecoveryViewModel.h"

@interface RecoverySuccessViewController()

// properties

@property (weak, nonatomic) IBOutlet UILabel  *infoLabel;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;

@property (strong, nonatomic) RecoveryViewModel* viewModel;

// methods


@end

@implementation RecoverySuccessViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self bindingUI];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Public methods -

- (void) setViewModel: (RecoveryViewModel*) model
{
    self.viewModel = model;
}


#pragma mark - Internal methods -

- (void) bindingUI
{
    // Fill info lable
    self.infoLabel.text = [self.viewModel getSuccessRestorePassLabel];
    
    // Setup binding ui with model
    self.registerBtn.rac_command = self.viewModel.registerCommand;
}

@end
