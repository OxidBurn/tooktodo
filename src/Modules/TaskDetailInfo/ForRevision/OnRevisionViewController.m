//
//  OnRevisionViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 13.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OnRevisionViewController.h"

// Classes
#import "OnRevisionViewModel.h"

// Categories
#import "UITextView+PlaceHolder.h"
#import "BaseMainViewController+NavigationTitle.h"

@interface OnRevisionViewController ()

//Outlets
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;
@property (weak, nonatomic) IBOutlet UIView *documentView;
@property (weak, nonatomic) IBOutlet UIButton *onDocumentAttach;
@property (weak, nonatomic) IBOutlet UILabel *documentNameLablel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *onSendButton;


@property (strong, nonatomic) OnRevisionViewModel* viewModel;

//Actions
- (IBAction) onBack: (UIBarButtonItem*) sender;

@end

@implementation OnRevisionViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self setupUI];
    
    [self bindingUI];
}


#pragma mark - Properties -

- (OnRevisionViewModel *)viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [OnRevisionViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Internal methods -

- (void) setupUI
{
    self.commentTextView.placeHolder      = @"Опишите причину отправки задачи на доработку. Ответственному будет отправлено сообщение о необходимости доработки.";
    self.commentTextView.placeHolderColor = [UIColor colorWithRed: 0.74 green:0.75 blue:0.76 alpha:1.00];
    self.commentTextView.placeHolderFont  = [UIFont fontWithName: @"SFUIText-Regular"
                                                            size: 15.0f];
    
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"НА ДОРАБОТКУ"
                                               withSubTitle: nil];
}

- (void) bindingUI
{
    RAC(self.viewModel, commentText) = self.commentTextView.rac_textSignal;
    
    self.onSendButton.rac_command = [self.viewModel sendReworkCommand];
    
    @weakify(self)
    
    [self.onSendButton.rac_command.executionSignals subscribeNext: ^(RACSignal* signal) {
        
        [signal subscribeCompleted: ^{
            
            @strongify(self)
            
            [self.navigationController popViewControllerAnimated: YES];
            
        }];
        
    }];
    
    [self.onSendButton.rac_command.errors subscribeNext: ^(NSError* error) {
        
        [Utils showErrorAlertWithMessage: @"Произошла ошибка во время отправки сообщения"];
        
    }];
}

#pragma mark - Actions -

- (IBAction) onBack: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

@end
