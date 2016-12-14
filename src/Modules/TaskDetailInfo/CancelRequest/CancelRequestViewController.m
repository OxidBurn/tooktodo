//
//  CancelRequestViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 17.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "CancelRequestViewController.h"

// Categories
#import "BaseMainViewController+NavigationTitle.h"

@interface CancelRequestViewController ()

@property (nonatomic, weak) IBOutlet UIBarButtonItem* backBtn;

- (IBAction) onBack: (UIBarButtonItem*) sender;

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


#pragma mark - Actions -

- (IBAction) onBack: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

@end
