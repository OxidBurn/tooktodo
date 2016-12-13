//
//  TaskViewController.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailViewController.h"

// Classes
#import "TaskDetailModel.h"
#import "TaskDetailViewModel.h"
#import "ProjectsEnumerations.h"
#import "ChangeStatusViewController.h"
#import "DataManager+Tasks.h"
#import "ProjectTasksViewController.h"
#import "TasksByProjectViewController.h"
#import "SystemDetailPopoverController.h"
#import "AddTaskViewController.h"
#import "OSTableView.h"
#import "ApproverViewController.h"

//Extentions
#import "BaseMainViewController+Popover.h"
#import "BaseMainViewController+NavigationTitle.h"


@interface TaskDetailViewController ()  <ChangeStatusControllerDelegate, UIPopoverPresentationControllerDelegate, UISplitViewControllerDelegate, AddTaskControllerDelegate>

// outlets
@property (weak, nonatomic) IBOutlet OSTableView* taskTableView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint* taskTableViewBottom;

// properties
@property (strong, nonatomic) TaskDetailViewModel* viewModel;
@property (strong, nonatomic) UITapGestureRecognizer *keyboardRecognizer;

// methods
- (IBAction) onBackBtn:   (UIBarButtonItem*) sender;

- (IBAction) onChangeBtn: (UIBarButtonItem*) sender;

- (IBAction) onSelectAttachmentsGesture: (UITapGestureRecognizer*) sender;

- (IBAction) onSelectLogsGesture: (UITapGestureRecognizer*) sender;

- (IBAction) onSelectSubtasksGesture: (UITapGestureRecognizer*) sender;

@end

#define kToolBarHeight (56)

@implementation TaskDetailViewController


#pragma mark - Lyfe cycle -

- (void) loadView
{
    [super loadView];
    
    [self setupNavigationTitleWithTwoLinesWithMainTitleText: [self.viewModel getTaskNumberTitle]
                                               withSubTitle: [self.viewModel getProjectTitle]];
    
    if ( IS_PHONE == NO)
        self.navigationItem.leftBarButtonItem = nil;
}

- (void) viewDidLoad
{
    [super viewDidLoad];
    
    [self setupDefaults];
    
    self.splitViewController.delegate = self;

    [self setKeyboardRecognizer: [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onTableClick:)]];
}

- (void) didReceiveMemoryWarning
{
    [NSNotificationCenter.defaultCenter removeObserver: self];

    [super didReceiveMemoryWarning];
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel reloadDataWithCompletion: ^(BOOL isSuccess) {
      
        [blockSelf.taskTableView reloadData];
        
    }];
    
    [self addNotifications];
}

- (void) viewWillDisappear: (BOOL) animated
{
    [super viewWillDisappear: animated];
    
    [self removeNotifications];
}

#pragma mark - Properties -

- (TaskDetailViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [[TaskDetailViewModel alloc] init];
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
        
        [vc fillControllerType: AddSubtaskControllerType];
        
        [vc fillDefaultStage: [self.viewModel getTaskStage]
              andHiddenState: [self.viewModel getTaskState]];
        
        [self removeNotifications];
    }
    
    if ( [segue.identifier isEqualToString: @"ShowEditTaskController"] )
    {
        UINavigationController* destinationNavController = segue.destinationViewController;
        
        AddTaskViewController* vc = (AddTaskViewController*)destinationNavController.topViewController;
        
        [vc fillControllerType: EditTaskControllerType];
        
        [vc fillTaskToEdit: [self.viewModel getCurrentTask]];
        
        [self removeNotifications];
    }
}

#pragma mark - Actions -

- (IBAction) onBackBtn: (UIBarButtonItem*) sender
{
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel deselectTaskWithCompletion:^(BOOL isSuccess) {
        
        //TODO: Need to make more cleaner solution
        [blockSelf.navigationController.navigationController popViewControllerAnimated: YES];
        
    }];
}

- (IBAction) onChangeBtn: (UIBarButtonItem*) sender
{
    [self performSegueWithIdentifier: @"ShowEditTaskController"
                              sender: self];
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

- (void) onTableClick: (id) sender
{
    [self.viewModel hideKeyboard];
    self.taskTableViewBottom.constant = 0;
    [self.taskTableView removeGestureRecognizer:self.keyboardRecognizer];
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


#pragma mark - UIPopoverPresentationControllerDelegate methods -

- (UIModalPresentationStyle) adaptivePresentationStyleForPresentationController: (UIPresentationController*) controller
{
    return UIModalPresentationNone;
}


#pragma mark - AddTaskControllerDelegate methods -

- (void) subscribeNotifications
{
    [self addNotifications];
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
    
    [self popoverSettings];
    
    self.viewModel.showSortingPopoverBlock = ^(CGRect frame){
        
      [blockSelf showPopoverWithDataSource: blockSelf.viewModel
                              withDelegate: blockSelf.viewModel
                           withSourceFrame: frame
                             withDirection: UIPopoverArrowDirectionAny];
    };
    
    
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
        popoverVC.permittedArrowDirections         = UIPopoverArrowDirectionDown | UITextLayoutDirectionUp;
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

- (void) handleKeyboardAppearing: (NSNotification*) notification
{
    [self.taskTableView addGestureRecognizer: self.keyboardRecognizer];
    
    CGFloat height = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
    
    self.taskTableViewBottom.constant = height - kToolBarHeight;
    self.viewModel.keyboardHeight = height;
    
    dispatch_after (dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        if (self.viewModel.model.getSecondSectionContentType != CommentsContentType) {
            return;
        }
        
        [self.viewModel scrollToCommentCell];
        self.taskTableView.scrollEnabled = false;
        self.taskTableView.blockScroll = true;
    });

}

- (void) handleKeyboardDissappearing: (NSNotification*) notification
{
    if (self.viewModel.model.getSecondSectionContentType != CommentsContentType) {
                                                                return;
                                                            }
                                                            self.taskTableViewBottom.constant = 0;
                                                            self.taskTableView.scrollEnabled = true;
                                                            self.taskTableView.blockScroll = false;
}

- (void) addNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(handleKeyboardAppearing:)
                                                 name: UIKeyboardWillShowNotification
                                               object: nil];
    
    [[NSNotificationCenter defaultCenter] addObserver: self
                                             selector: @selector(handleKeyboardDissappearing:)
                                                 name: UIKeyboardWillHideNotification
                                               object: nil];
}

- (void) removeNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillShowNotification
                                                  object: nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver: self
                                                    name: UIKeyboardWillHideNotification
                                                  object: nil];
}

@end
