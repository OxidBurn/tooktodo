//
//  SelectionPremisesController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectionPremisesController.h"

@interface SelectionPremisesController ()

// Properties
@property (weak, nonatomic) IBOutlet UITableView* selectionPremisesTableView;

// Methods
- (IBAction)  onResetBtn: (UIButton*) sender;
- (IBAction)   onSaveBtn: (UIButton*) sender;
- (IBAction)   onDoneBtn: (UIBarButtonItem*) sender;
- (IBAction) onCancelBtn: (UIBarButtonItem*) sender;


@end

@implementation SelectionPremisesController

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

- (IBAction) onResetBtn: (UIButton*) sender
{
    
}

- (IBAction) onSaveBtn: (UIButton*) sender
{
    
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onCancelBtn: (UIBarButtonItem*) sender
{
    
}
@end
