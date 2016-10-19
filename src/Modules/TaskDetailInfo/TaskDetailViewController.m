//
//  TaskViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailViewController.h"

// Classes
#import "TaskDetailViewModel.h"
#import "ProjectsEnumerations.h"
#import "ChangeStatusViewController.h"
#import "DataManager+Tasks.h"

@interface TaskDetailViewController ()  <ChangeStatusControllerDelegate>

// outlets
@property (weak, nonatomic) IBOutlet UITableView* taskTableView;

// properties
@property (strong, nonatomic) TaskDetailViewModel* viewModel;

// methods
- (IBAction) onBackBtn:   (UIBarButtonItem*) sender;

- (IBAction) onChangeBtn: (UIBarButtonItem*) sender;

- (IBAction) onSelectAttachmentsGesture: (UITapGestureRecognizer*) sender;

- (IBAction) onSelectLogsGesture: (UITapGestureRecognizer*) sender;

- (IBAction) onSelectSubtasksGesture: (UITapGestureRecognizer*) sender;

@end

@implementation TaskDetailViewController

#pragma mark - Lyfe cycle -

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupDefaults];
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Properties -

- (TaskDetailViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [TaskDetailViewModel new];
    }
    
    return _viewModel;
}

#pragma mark - Public -

- (TaskStatusType) getStatusType
{
    return [self.viewModel getTaskStatus];
}

#pragma mark - Segue -

- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id) sender
{
    if ([segue.identifier isEqualToString: @"ShowStatusList"])
    {
        
        UINavigationController* destinationNavController = segue.destinationViewController;
        ChangeStatusViewController* vc = (ChangeStatusViewController*)destinationNavController.topViewController;
        
        vc.delegate = self;
    }
    
}

#pragma mark - Actions -

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.viewModel deselectTask];
    
    [self.navigationController popViewControllerAnimated: YES];
}

- (IBAction) onChangeBtn: (UIBarButtonItem*) sender
{
    
}

- (IBAction) onSelectAttachmentsGesture: (UITapGestureRecognizer*) sender
{
    [self.viewModel updateSecondSectionContentForType: AttachmentsContentType];
}

- (IBAction) onSelectLogsGesture: (UITapGestureRecognizer*) sender
{
    [self.viewModel updateSecondSectionContentForType: CommentsContentType];
}

- (IBAction) onSelectSubtasksGesture: (UITapGestureRecognizer*) sender
{
    [self.viewModel updateSecondSectionContentForType: SubtasksContentType];
}


#pragma mark - ChangeStatusControllerDelegate methods -

- (void) performSegueWithID: (NSString*) segueID
{
    [self performSegueWithIdentifier: segueID
                              sender: self];
}

- (void) updataTaskDetailInfoTaskStatus
{
    [self.viewModel updateTaskStatus];
    
    [self.taskTableView reloadData];
}


#pragma mark - Helpers -

- (void) setupDefaults
{
    self.taskTableView.dataSource = self.viewModel;
    self.taskTableView.delegate   = self.viewModel;
    
    self.taskTableView.rowHeight = UITableViewAutomaticDimension;
    self.taskTableView.estimatedRowHeight = 58;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^(){
        
        [blockSelf.taskTableView reloadData];
    };
    
    self.viewModel.performSegue = ^(NSString* segueID){
        
        [blockSelf performSegueWithIdentifier: segueID
                                       sender: blockSelf];
    };
}


@end
