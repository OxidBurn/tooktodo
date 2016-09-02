//
//  AboutProjectViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AboutProjectViewController.h"
#import "MainTabBarController.h"
#import "ProjectsControllersDelegate.h"

@interface AboutProjectViewController ()

// properties

@property (weak, nonatomic) id <ProjectsControllersDelegate> delegate;

// methods

- (IBAction) selectedSegmentItemIndex: (UISegmentedControl*) sender;


@end

@implementation AboutProjectViewController

#pragma mark - Life cycle -

- (void)loadView
{
    [super loadView];
    
    [self twoLineTitleView];
    
    // setup delegate
    self.delegate = (MainTabBarController*)self.navigationController.parentViewController;
    
    [self showInfoScreenWithID: @"GoToProjInformation"];
    
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Memory managment -


- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Action -

- (IBAction) selectedSegmentItemIndex: (UISegmentedControl*) sender
{
    if ( sender.selectedSegmentIndex == 1 )
    {
        [self showInfoScreenWithID: @"GoToRoles"];
    }
    
    else if ( sender.selectedSegmentIndex == 0 )
    {
        [self showInfoScreenWithID: @"GoToProjInformation"];
    }
    
    else
    {
        [self showInfoScreenWithID: @"GoToSystemInfo"];
    }
    
}

#pragma mark - Internal method -

- (void) showInfoScreenWithID: (NSString*) storyboardID
{
    [self performSegueWithIdentifier: storyboardID
                              sender: self];
}


- (UIView*) twoLineTitleView
{
    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 14.0f];
    UIFont* customFontForSubTitle = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 13.0f];
    
    UILabel* titleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor       = [UIColor whiteColor];
    titleLabel.font            = customFont;
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    titleLabel.text            = @"О ПРОЕКТЕ";
    [titleLabel sizeToFit];
    
    UILabel* subTitleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 17, 0, 0)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor       = [UIColor whiteColor];
    subTitleLabel.font            = customFontForSubTitle;
    subTitleLabel.textAlignment   = NSTextAlignmentCenter;
    subTitleLabel.text            = @"Квартира на Ходынке";
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

@end
