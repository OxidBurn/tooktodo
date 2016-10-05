//
//  SelectionPremisesController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 9/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "SelectRoomViewController.h"

//Frameworks
#import "ReactiveCocoa.h"

//Classes
#import "SelectRoomViewModel.h"

@interface SelectRoomViewController ()

// Properties
@property (weak, nonatomic) IBOutlet UITableView* roomLevelTableView;
@property (nonatomic, strong) SelectRoomViewModel* viewModel;

// Methods
- (IBAction)  onResetBtn: (UIButton*) sender;
- (IBAction)   onSaveBtn: (UIButton*) sender;
- (IBAction)   onDoneBtn: (UIBarButtonItem*) sender;
- (IBAction) onCancelBtn: (UIBarButtonItem*) sender;


@end

@implementation SelectRoomViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self bindUI];
    
    [self updateContent];
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

#pragma mark - Properties -

- (SelectRoomViewModel*) viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [SelectRoomViewModel new];
    }
    
    return _viewModel;
}


#pragma mark - Interal -

- (void) bindUI
{
    self.roomLevelTableView.dataSource = self.viewModel;
    self.roomLevelTableView.delegate   = self.viewModel;
}


- (void) updateContent
{
    @weakify(self)
    
    [[self.viewModel updateContent]
     subscribeCompleted: ^{
         
         @strongify(self)
         
         [self.roomLevelTableView reloadData];
         
     }];
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
    [self.navigationController popViewControllerAnimated: YES];
}
@end
