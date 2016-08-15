//
//  UserInfoViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "UserInfoViewController.h"

@interface UserInfoViewController ()

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

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Actions -

- (IBAction) toggleMenu: (UIBarButtonItem*) sender
{
    [self.slidingViewController anchorTopViewToRightAnimated: YES];
}


@end
