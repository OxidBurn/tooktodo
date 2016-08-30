//
//  TeamInfoViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 8/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TeamInfoViewController.h"


// Categories
#import "BaseMainViewController+NavigationTitle.h"

@interface TeamInfoViewController ()

// Properties
@property (weak, nonatomic) IBOutlet UITableView* teamInfoTableView;
@property (nonatomic, strong) InviteInfo* inviteInfo;

// Methods

@end

@implementation TeamInfoViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    // Setup navigation title view
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: @"КОМАНДА"
                                               withSubTitle: @"Квартира на Ходынке"];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

- (void) fillInviteInfo: (InviteInfo*) userInf
{
    self.inviteInfo = userInf;
}


#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
