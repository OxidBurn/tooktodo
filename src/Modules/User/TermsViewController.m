//
//  TermsViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/18/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()

@property (weak, nonatomic) IBOutlet UITextView* termsText;

@end

@implementation TermsViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    // Do any additional setup after loading the view.
    
    [self titleLabel];
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions -


- (IBAction) onDismiss: (UIButton*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}


#pragma mark - Internal methods -

- (UILabel*) titleLabel
{
    UIFont* customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                         size: 14.0f];
    
    UILabel* label        = [[UILabel alloc] initWithFrame:CGRectMake((self.view.width - 250) / 2, 0, 250, 36)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines   = 2;
    label.font            = customFont;
    label.textAlignment   = NSTextAlignmentCenter;
    label.textColor       = [UIColor whiteColor];
    label.text            = @"ПОЛЬЗОВАТЕЛЬСКОЕ СОГЛАШЕНИЕ";
    
    [label sizeToFit];
    
    
    
    self.navigationItem.titleView = label;
    
    return label;
}

@end
