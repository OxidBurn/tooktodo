//
//  OSAlertDeleteTasksController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 18.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "OSAlertDeleteTasksController.h"

@interface OSAlertDeleteTasksController ()

// outlets
@property (weak, nonatomic) IBOutlet UILabel* taskTitleLabel;

// methods

- (IBAction) onDeleteBtn: (UIButton*) sender;
- (IBAction) onCancelBtn: (UIButton*) sender;

@end

@implementation OSAlertDeleteTasksController

- (instancetype) init
{
    self = [super init];
    
    return self;
}


#pragma mark - Lyfe cycle -

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void) setTaskTitle: (NSString*) title
{
    self.taskTitleLabel.text = title;
}

#pragma mark - Actions -

- (IBAction) onDeleteBtn: (UIButton*) sender
{
    
}

- (IBAction) onCancelBtn: (UIButton*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

@end

