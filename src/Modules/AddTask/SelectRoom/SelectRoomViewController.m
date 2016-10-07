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
#import "ProjectTaskRoom+CoreDataClass.h"
#import "ProjectTaskRoomLevel+CoreDataClass.h"

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


#pragma mark - Public -

- (void) fillSelectedRoom: (id) room
             withDelegate: (id<SelectRoomViewController>) delegate
{
    [self.viewModel fillSelectedRoom: room];
    
    self.delegate = delegate;
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

- (void) saveData
{
    id selectedInfo = [self.viewModel getSelectedInfo];
    
    if ([self.delegate respondsToSelector: @selector(returnSelectedInfo:)])
    {
        [self.delegate returnSelectedInfo: selectedInfo];
        
        [self.navigationController popViewControllerAnimated: YES];
    }
}

#pragma mark - Actions -

- (IBAction) onResetBtn: (UIButton*) sender
{
    [self.viewModel resetAllWithCompletion: ^(BOOL isSuccess) {
        
        [self.roomLevelTableView reloadData];
        
    }];
    
[self.navigationController popViewControllerAnimated: YES];
    
}

- (IBAction) onSaveBtn: (UIButton*) sender
{
    [self saveData];
}

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    [self saveData];
}

- (IBAction) onCancelBtn: (UIBarButtonItem*) sender
{
    [self.navigationController popViewControllerAnimated: YES];
}
@end
