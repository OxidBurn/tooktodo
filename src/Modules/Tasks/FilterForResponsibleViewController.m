//
//  FilterForResponsibleViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "FilterForResponsibleViewController.h"

@interface FilterForResponsibleViewController ()

// Properties
@property (weak, nonatomic) IBOutlet UITableView* filterForResponsibleTableView;
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;

// Methods
- (IBAction) onSelectedAllBtn: (UIButton*) sender;
- (IBAction)        onSaveBtn: (UIButton*) sender;
- (IBAction)        onDoneBtn: (UIBarButtonItem*) sender;
- (IBAction)        onBackBtn: (UIBarButtonItem*) sender;


@end

@implementation FilterForResponsibleViewController

#pragma mark - Life cycle -

- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Action -

- (IBAction) onSelectedAllBtn: (UIButton*) sender
{
    
}

- (IBAction) onSaveBtn: (UIButton*) sender
{
    
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    
}
@end
