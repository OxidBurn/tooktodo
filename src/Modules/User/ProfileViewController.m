//
//  ProfileViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/17/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ProfileViewController.h"

// Classes
#import "ProjectsControllersDelegate.h"
#import "MainTabBarController.h"

// Categories
#import "UIViewController+Helper.h"
#import "BaseMainViewController+NavigationTitle.h"

@interface ProfileViewController ()

// properties

@property (weak, nonatomic) id <ProjectsControllersDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem* editUserInfoBtn;

// methods

- (IBAction) selectedSegmentItemIndex: (UISegmentedControl*) sender;

@end

@implementation ProfileViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // setup delegate
    self.delegate = (MainTabBarController*)self.navigationController.parentViewController;
    
    [self showInfoScreenWithID: @"UserDetailScreen"];
    
    [self titleLabel];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self determineLeftBarButtonItem];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions -

- (IBAction) selectedSegmentItemIndex: (UISegmentedControl*) sender
{
    if ( sender.selectedSegmentIndex == 0 )
    {
        self.editUserInfoBtn.customView.hidden = NO;
        
        [self showInfoScreenWithID: @"UserDetailScreen"];
    }
    else
    {
        self.editUserInfoBtn.customView.hidden = YES;
        
        [self showInfoScreenWithID: @"UserNotificationsScreen"];
    }
}


#pragma mark - Actions -

- (void) leftBarButtonActionForiPhone
{
    if ( [self.delegate respondsToSelector: @selector(showMainMenu)] )
    {
        [self.delegate showMainMenu];
    }
}

- (void) leftBarButtonActionForiPad
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
    
}


#pragma mark - Internal methods -

- (void) showInfoScreenWithID: (NSString*) storyboardID
{
    [self performSegueWithIdentifier: storyboardID
                              sender: self];
}

- (UILabel*) titleLabel
{
    UIFont* customFont = [UIFont fontWithName: @"SFUIText-Regular"
                                         size: 14.0f];
    
    UILabel* label        = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 480, 18)];
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines   = 1;
    label.font            = customFont;
    label.textAlignment   = NSTextAlignmentCenter;
    label.textColor       = [UIColor whiteColor];
    label.text            = @"ВАШ ПРОФИЛЬ";

    [label sizeToFit];
    
    
    
    self.navigationItem.titleView = label;
    
    return label;
}

- (void) determineLeftBarButtonItem
{   
    self.navigationItem.leftBarButtonItem = [self determineMenuBtnToBackBtnWithSelectorForiPhone: @selector(leftBarButtonActionForiPhone)
                                                                                 andSelectoriPad: @selector(leftBarButtonActionForiPad)];
}

@end
