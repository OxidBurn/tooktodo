//
//  ApproverViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 11/25/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "ApproverViewController.h"

@interface ApproverViewController ()

// Properties

@property (weak, nonatomic) IBOutlet UITableView *approverTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBarButtonItem;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneBarButtonItem;

// Methods
- (IBAction) onDone: (UIBarButtonItem*) sender;

- (IBAction) onBackBtn: (UIBarButtonItem*) sender;

@end

@implementation ApproverViewController


#pragma mark - Life cycle -

- (void) viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


#pragma mark - Public -

- (void) fillApprovers: (NSArray*) approvers
{
    
}


#pragma mark - Actions -

- (IBAction) onDone: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}
@end
