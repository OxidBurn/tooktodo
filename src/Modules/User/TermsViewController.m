//
//  TermsViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/18/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TermsViewController.h"
#import "BaseMainViewController+NavigationTitle.h"

@interface TermsViewController ()

@property (weak, nonatomic) IBOutlet UITextView* termsText;

@end

@implementation TermsViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self twoLineTitleView];
    
    [self setupTermsTextView];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self.termsText setContentOffset:CGPointZero animated:NO];
}
#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions -

- (IBAction) onDismiss: (UIBarButtonItem*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

#pragma mark - Internal method -

- (UIView*) twoLineTitleView
{
    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 14.0f];
    
    UILabel* titleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor       = [UIColor whiteColor];
    titleLabel.font            = customFont;
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.text            = @"ПОЛЬЗОВАТЕЛЬСКОЕ";
    [titleLabel sizeToFit];
    
    UILabel* subTitleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 17, 0, 0)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor       = [UIColor whiteColor];
    subTitleLabel.font            = customFont;
    subTitleLabel.textAlignment   = NSTextAlignmentCenter;
    subTitleLabel.text            = @"СОГЛАШЕНИЕ";
    [subTitleLabel sizeToFit];
    
    UIView* twoLineTitleView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, MAX(subTitleLabel.frame.size.width, titleLabel.frame.size.width), 32)];
    
    [twoLineTitleView addSubview: titleLabel];
    [twoLineTitleView addSubview: subTitleLabel];
    
    float widthDiff = subTitleLabel.frame.size.width - titleLabel.frame.size.width;
    
    if (widthDiff > 0)
    {
        CGRect frame     = titleLabel.frame;
        frame.origin.x   = widthDiff / 2;
        titleLabel.frame = CGRectIntegral(frame);
    }
    else
    {
        CGRect frame        = subTitleLabel.frame;
        frame.origin.x      = fabsf(widthDiff) / 2;
        subTitleLabel.frame = CGRectIntegral(frame);
    }
    
    self.navigationItem.titleView = twoLineTitleView;
    
    return twoLineTitleView;
}

- (void) setupTermsTextView
{
    self.termsText.textContainerInset = UIEdgeInsetsMake(20, 18, 0, 22);
    self.termsText.text               = [NSString stringWithContentsOfFile: [MainBundle pathForResource: @"service_agreements"
                                                                                                 ofType: @"txt"]
                                                                  encoding: NSUTF8StringEncoding
                                                                     error: nil];
}

@end
