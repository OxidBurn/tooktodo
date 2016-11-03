//
//  RolesViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 29.08.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "RolesViewController.h"
#import "RolesViewModel.h"

@interface RolesViewController ()

// properties
@property (weak, nonatomic  ) IBOutlet UITableView             * rolesTableView;
@property (strong, nonatomic) RolesViewModel                   * rolesViewModel;
@property (weak, nonatomic  ) IBOutlet UIBarButtonItem         * readyBtn;
@property (weak, nonatomic  ) id <RolesViewControllerDelegate> delegate;

// methods

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

- (void) loadView
{
    [super loadView];
    
    // Binding between UI and model
    [self bindingUI];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    // Fetch latest data of the project roles
    @weakify(self)
    
    [[self.rolesViewModel updateRolesInfo] subscribeNext: ^(id x) {
        
        @strongify(self)
        
        [self.rolesTableView reloadData];
        
    }];
}

#pragma mark - Public methods -

- (void) setRolesViewControllerDelegate: (id<RolesViewControllerDelegate>) delegate
{
    self.delegate = delegate;
}

#pragma mark - Internal methods -

- (void) bindingUI
{
    self.rolesTableView.dataSource = self.rolesViewModel;
    self.rolesTableView.delegate   = self.rolesViewModel;
}

#pragma mark - Actions -

- (IBAction) onDismiss: (UIBarButtonItem*) sender
{
    if (IS_PHONE)
    {
          [self.navigationController popViewControllerAnimated: YES];
    }
    
    else
        [self dismissViewControllerAnimated: YES
                                 completion: nil];
}

- (IBAction) onReady: (UIBarButtonItem*) sender
{
    [self saveSelectedRole];
}

- (IBAction) onAddRole: (UIButton*) sender
{
    [self saveSelectedRole];
}


#pragma mark - Helpers -

- (void) saveSelectedRole
{
    if ( self.delegate )
        [self.delegate didSelectRole: [self.rolesViewModel getSelectedItem]];
    
        [self.navigationController popViewControllerAnimated: YES];

    
    
}

@end
