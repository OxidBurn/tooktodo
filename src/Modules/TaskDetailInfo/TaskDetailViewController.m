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
#import "ProjectTasksViewController.h"
#import "TasksByProjectViewController.h"
#import "SystemDetailPopoverController.h"
#import "AddTaskViewController.h"


@interface TaskDetailViewController ()  <ChangeStatusControllerDelegate, UIPopoverPresentationControllerDelegate, UISplitViewControllerDelegate>

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

- (void) loadView
{
    [super loadView];
    
    if ( IS_PHONE == NO)
        self.navigationItem.leftBarButtonItem = nil;

}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupDefaults];
    
    self.splitViewController.delegate = self;
}

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    [self.taskTableView reloadData];
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

- (void) fillSelectedTask: (ProjectTask*) task
{
    [self.viewModel fillSelectedTask: task
                      withCompletion: ^(BOOL isSuccess) {
         
         [self refreshTableView];
     }];
    
}

- (void) refreshTableView
{
    [self.taskTableView reloadData];
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
    
    if ([segue.identifier isEqualToString: @"ShowAddSubtask"])
    {
        UINavigationController* destinationNavController = segue.destinationViewController;
        
        AddTaskViewController* vc = (AddTaskViewController*)destinationNavController.topViewController;
        
        [vc fillDefaultStage: [self.viewModel getTaskStage]
              andHiddenState: [self.viewModel getTaskState]];
        
        [vc fillControllerType: AddSubtaskControllerType];
    }
    
}

#pragma mark - Actions -

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    [self.viewModel deselectTask];
    
    //TODO: Need to make more cleaner solution
    [self.navigationController.navigationController popViewControllerAnimated: YES];
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


#pragma mark - UIPopoverPresentationControllerDelegate methods -

-(UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController*) controller
{
    return UIModalPresentationNone;
}

#pragma mark - Helpers -

- (void) setupDefaults
{
    self.taskTableView.dataSource = self.viewModel;
    self.taskTableView.delegate   = self.viewModel;
    
    self.taskTableView.rowHeight = UITableViewAutomaticDimension;
    self.taskTableView.estimatedRowHeight = 58;
    
    __weak typeof(self) blockSelf = self;
    
    blockSelf.viewModel.reloadTableView = ^(){
        
        [blockSelf.taskTableView reloadData];
    };
    
    blockSelf.viewModel.performSegue = ^(NSString* segueID){
        
        [blockSelf performSegueWithIdentifier: segueID
                                       sender: blockSelf];
    };
    
    [self popoverSettings];
}


- (BOOL)    splitViewController: (UISplitViewController*) splitViewController
collapseSecondaryViewController: (UIViewController*)      secondaryViewController
      ontoPrimaryViewController: (UIViewController*)      primaryViewController
{
    return YES;
}

- (BOOL) splitViewController: (UISplitViewController*) splitViewController
    showDetailViewController: (UIViewController*)      vc
                      sender: (id)                     sender
{
    if ( ([sender isKindOfClass: [ProjectTasksViewController class]] &&
         [((ProjectTasksViewController*)sender).taskDetailVC isKindOfClass: [TaskDetailViewController class]]) ||
        ([sender isKindOfClass: [TasksByProjectViewController class]] &&
         [((TasksByProjectViewController*)sender).taskDetailVC isKindOfClass: [TaskDetailViewController class]]))
    {
        return NO;
    }
    
    return YES;
}


- (void) popoverSettings
{
    __weak typeof (self) blockSelf = self;
    
    self.viewModel.presentControllerAsPopover = ^(CGRect frame) {
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName: @"Tasks"
                                                             bundle: nil];
        
        SystemDetailPopoverController* contentController = [storyboard instantiateViewControllerWithIdentifier: @"PopoverViewController"];
        
        contentController.modalPresentationStyle   = UIModalPresentationPopover;
        UIPopoverPresentationController* popoverVC = contentController.popoverPresentationController;
        popoverVC.permittedArrowDirections         = UIPopoverArrowDirectionDown;
        contentController.preferredContentSize     = CGSizeMake(180, 41);
        popoverVC.containerView.layer.cornerRadius = 3.0f;
        
        popoverVC.sourceView = blockSelf.taskTableView;
        popoverVC.sourceRect = frame;
        popoverVC.delegate   = blockSelf;
        
        [blockSelf presentViewController: contentController
                                animated: YES
                              completion: nil];

    };
}


@end
