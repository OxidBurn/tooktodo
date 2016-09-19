//
//  AddTermTasksViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTermTasksViewController.h"

@interface AddTermTasksViewController ()

//Properties
@property (weak, nonatomic) IBOutlet UITableView* addTermTasksTableView;

//Methods
- (IBAction) onDoneBtn: (UIBarButtonItem*) sender;
- (IBAction) onBackBtn: (UIBarButtonItem*) sender;
- (IBAction) onSaveBtn: (UIButton*) sender;


@end

@implementation AddTermTasksViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Action -

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onSaveBtn: (UIButton*) sender
{
    
}
@end
