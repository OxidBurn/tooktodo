//
//  CancelRequestViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 17.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CancelRequestViewController.h"

// Classes
#import "CancelRequestViewModel.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"

@interface CancelRequestViewController ()

// outlets
@property (nonatomic, weak) IBOutlet UIBarButtonItem* backBtn;
@property (weak, nonatomic) IBOutlet UITextView* textView;

// properties
@property (strong, nonatomic) CancelRequestViewModel* viewModel;

// methods
- (IBAction) onBack: (UIBarButtonItem*) sender;
- (IBAction) onReadyBtn: (UIBarButtonItem*) sender;

@end

@implementation CancelRequestViewController

#pragma mark - Life cycle -

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"ЗАПРОС НА ОТМЕНУ"
                                               withSubTitle: nil];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (CancelRequestViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [CancelRequestViewModel new];
    }
    
    return _viewModel;
}



#pragma mark - Actions -

- (IBAction) onBack: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onReadyBtn: (UIBarButtonItem*) sender
{
    [self.viewModel sendRequestLetter: self.textView.text];
}

@end
