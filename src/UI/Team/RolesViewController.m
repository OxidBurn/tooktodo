//
//  RolesViewController.m
//  TookTODO
//
//  Created by Lera on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RolesViewController.h"
#import "RolesViewModel.h"

@interface RolesViewController ()

@property (weak, nonatomic) IBOutlet UITableView *rolesTableView;
@property (nonatomic, strong) RolesViewModel* rolesViewModel;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *readyBtn;
@property (nonatomic, weak) id<RolesViewControllerDelegate> delegate;

@end

@implementation RolesViewController

#pragma mark - Properties -

- (RolesViewModel*) rolesViewModel
{
    if (_rolesViewModel == nil)
    {
        _rolesViewModel = [[RolesViewModel alloc] init];
    }
    
    return _rolesViewModel;
}

#pragma mark - Life cycle -

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    self.rolesTableView.dataSource = self.rolesViewModel;
    self.rolesTableView.delegate = self.rolesViewModel;
    
    //  [self handleModelActions];
    
}

#pragma mark - Public methods -

- (void) setRolesViewControllerDelegate: (id<RolesViewControllerDelegate>) delegate
{
    self.delegate = delegate;
}

#pragma mark - Actions -

- (IBAction) onDismiss: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}
- (IBAction) onReady: (UIBarButtonItem*) sender
{
    
    if ( self.delegate )
        [self.delegate didSelectRole: [self.rolesViewModel getSelectedItem]];
    
    [self.navigationController popViewControllerAnimated: YES];
}



@end
