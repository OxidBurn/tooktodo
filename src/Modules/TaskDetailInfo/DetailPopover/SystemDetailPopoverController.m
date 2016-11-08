//
//  SystemDetailPopoverController.m
//  TookTODO
//
//  Created by Lera on 24.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SystemDetailPopoverController.h"
#import "SystemDetailViewModel.h"

@interface SystemDetailPopoverController ()

//Outlets

@property (nonatomic, weak) IBOutlet UILabel* fullTitleLabel;

//Properties

@property (nonatomic, strong) SystemDetailViewModel* viewModel;

@end

@implementation SystemDetailPopoverController

#pragma mark - Life Cycle -

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.fullTitleLabel.text = [self.viewModel getProjectSystemDetails];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    self.view.superview.layer.cornerRadius = 7.0f;
}


#pragma mark - Properties -

- (SystemDetailViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [SystemDetailViewModel new];
    }
    
    return _viewModel;
}

@end
