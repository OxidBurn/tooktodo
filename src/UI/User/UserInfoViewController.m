//
//  UserInfoViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserInfoViewController.h"
#import "UserInfoViewModel.h"

@interface UserInfoViewController ()

// Properties


@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel     *fullNameLabel;

@property (strong, nonatomic) UserInfoViewModel* viewModel;

// methods
@end

@implementation UserInfoViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    [self updateInfo];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Properties -

- (UserInfoViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [UserInfoViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Actions -

- (IBAction) toggleMenu: (UIBarButtonItem*) sender
{
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}


#pragma mark - Internal methods -

- (void) updateInfo
{
    self.avatarImageView.image = [self.viewModel userAvatar];
    self.fullNameLabel.text    = [self.viewModel fullUserName];
}

@end
