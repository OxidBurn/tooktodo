//
//  AddTaskViewController.m
//  TookTODO
//
//  Created by Nikolay Chaban on 12.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskViewController.h"

// Classes
#import "AddTaskViewModel.h"
#import "SelectResponsibleViewController.h"
#import "ProjectsEnumerations.h"
#import "AddMessageViewController.h"
#import "AddTermTasksViewController.h"
#import "SelectStageViewController.h"
#import "SelectSystemViewController.h"
#import "NewTask.h"
#import "TeamInfoViewController.h"
#import "SelectRoomViewController.h"
#import "AddTaskTypeViewController.h"
#import "ProjectsEnumerations.h"
#import "AddTaskModel.h"
#import "OSAlertController.h"

@interface AddTaskViewController () <AddTaskViewModelDelegate, AddTaskModelDataSource>

// outlets

@property (weak, nonatomic) IBOutlet UIBarButtonItem* readyBtn;
@property (weak, nonatomic) IBOutlet UIButton*        addTaskAndCreateNewBtn;
@property (weak, nonatomic) IBOutlet UIButton*        addTaskBtn;
@property (nonatomic, weak) IBOutlet UIButton*        deleteTask;
@property (weak, nonatomic) IBOutlet UITableView*     addTaskTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* cancelBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *messageView;

@property (weak, nonatomic) IBOutlet UILabel*  messageLabel;
@property (weak, nonatomic) IBOutlet UIButton* closeBtn;
@property (nonatomic, weak) IBOutlet UIButton* createOnBaseBtn;

// properties

@property (strong, nonatomic) AddTaskViewModel* viewModel;
@property (nonatomic, assign) BOOL isChangedUI;
@property (nonatomic, assign) AddTaskControllerType controllerType;

// methods
- (IBAction) onDoneBtn: (UIBarButtonItem*) sender;

- (IBAction) onAddAndCreateNewBtn: (UIButton*) sender;

- (IBAction) onAddTaskBtn: (UIButton*) sender;

- (IBAction) onCancel: (UIBarButtonItem*) sender;

- (IBAction) onClose:(UIButton*) sender;

- (IBAction) onDeleteTask: (UIButton*) sender;

- (IBAction) onCreteOnBase: (UIButton*) sender;

@end

@implementation AddTaskViewController


#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self twoLineTitleView];
    
    [self setUpDefaults];
    
    [self bindUI];
    
    self.isChangedUI = NO;
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
        
    [self.addTaskTableView reloadData];
}


#pragma mark - Segue -

- (void) prepareForSegue: (UIStoryboardSegue*) segue
                  sender: (id)                 sender
{
    [super prepareForSegue: segue sender: sender];
    
    NewTask* task = [self.viewModel getNewTask];
    
    NSUInteger segueIndex = [[self.viewModel returnAllSeguesArray] indexOfObject: segue.identifier];
    
    switch ( segueIndex )
    {
        case ShowAddMessageSegue:
        {
            AddMessageViewController* AddMessageController = [segue destinationViewController];
            
            [AddMessageController updateDescription: task.taskDescription
                                   andReturnToModel: [self.viewModel returnModel]];
        }
            break;
            
        case ShowResponsibleSegue:
        {
            SelectResponsibleViewController* controller = [segue destinationViewController];
            
            [controller fillSelectedUsersInfo: [self.viewModel returnSelectedResponsibleArray]];

            [controller updateControllerType: SelectResponsibleController
                                 withMembers: [self.viewModel getAllMembersArray]
                                withDelegate: [self.viewModel returnModel]];
        }
            break;
            
        case ShowClaimingSegue:
        {
            SelectResponsibleViewController* controller = [segue destinationViewController];
            
            [controller updateControllerType: SelectClaimingController
                                 withMembers: [self.viewModel getAllMembersArray]
                                withDelegate: [self.viewModel returnModel]];
            
            [controller fillSelectedUsersInfo: [self.viewModel returnSelectedClaimingArray]];
        }
            break;
            
        case ShowObserversSegue:
        {
            SelectResponsibleViewController* controller = [segue destinationViewController];
            [controller updateControllerType: SelectObserversController
                                 withMembers: [self.viewModel getAllMembersArray]
                                withDelegate: [self.viewModel returnModel]];
            
            [controller fillSelectedUsersInfo: [self.viewModel returnSelectedObserversArray]];
        }
            break;
            
        case ShowTermsSegue:
        {
            AddTermTasksViewController* controller = [segue destinationViewController];
            
            [controller updateTerms: [self.viewModel returnTerms]
                       withDelegate: [self.viewModel returnModel]];
            
        }
            break;
            
        case ShowStagesSegue:
        {
            SelectStageViewController* controller = [segue destinationViewController];
            
            [controller fillSelectedStage: [self.viewModel returnSelectedStage]
                             withDelegate: [self.viewModel returnModel]];
        }
            break;
            
        case ShowSystemSegue:
        {
            SelectSystemViewController* controller = [segue destinationViewController];
            
            ProjectSystem* system = [self.viewModel returnSelectedSystem];
            
            [controller fillSelectedSystem: system
                              withDelegate: [self.viewModel returnModel]];
        }
            break;
            
        case ShowRoomsSegue:
        {
            SelectRoomViewController* controller = [segue destinationViewController];
           
            id room = [self.viewModel returnSelectedRoom];
            
            [controller fillSelectedRoom: room
                            withDelegate: [self.viewModel returnModel]];
        }
            break;
            
        case ShowTaskTypeSegue:
        {
            AddTaskTypeViewController* controller = [segue destinationViewController];
            
            TaskType type = [self.viewModel returnSelectedTaskType];
            
            [controller fillSelectedTaskType: type
                                withDelegate: [self.viewModel returnModel]];
        }
            
        default:
            break;
    }
}


#pragma mark - Properties -

- (AddTaskViewModel*) viewModel
{
    if ( _viewModel == nil )
    {
        _viewModel = [AddTaskViewModel new];
        
        _viewModel.delegate = self;
    }
    
    return _viewModel;
}


#pragma mark - Public -

- (void) fillDefaultStage: (ProjectTaskStage*) stage
           andHiddenState: (BOOL)              isHidden
{
    [self.viewModel fillDefaultStage: stage
                      andHiddenState: isHidden];
    
}

- (void) fillControllerType: (AddTaskControllerType) controllerType
{
    [self.viewModel fillControllerType: controllerType];
}

- (void) fillTaskToEdit: (ProjectTask*) taskToEdit
{
    [self.viewModel fillTaskToEdit: taskToEdit];
    
    [self changeUI];
}


#pragma mark - Actions -

- (IBAction) onDoneBtn: (UIBarButtonItem*) sender
{
    [self.viewModel storeNewTaskWithCompletion: ^(BOOL isSuccess) {
        
        [self dismissViewControllerAnimated: YES
                                 completion: nil];
    }];
}

- (IBAction) onAddAndCreateNewBtn: (UIButton*) sender
{
    [self.viewModel storeNewTaskWithCompletion: nil];
}

- (IBAction) onAddTaskBtn: (UIButton*) sender
{
    [self.viewModel storeNewTaskWithCompletion: ^(BOOL isSuccess) {
       
        [self dismissViewControllerAnimated: YES
                                 completion: nil];
    }];
}

- (IBAction) onCancel: (UIBarButtonItem*) sender
{
    [self.viewModel deselectAllRoomsInfo];
    
    [self dismissViewControllerAnimated: YES
                             completion: nil];
}

- (IBAction) onClose: (UIButton*) sender
{
    self.messageView.hidden              = YES;
    self.tableViewTopConstraint.constant = 0;
}

- (IBAction) onDeleteTask: (UIButton*) sender
{
    BOOL hasSubtasks = [self.viewModel checkSubtasks];
    
    if ( hasSubtasks)
    {
        [OSAlertController showAlertWithDeleteTaskOnController: self
                                                  withDelegate: self.viewModel];
    }
    else
    {
        NSString* taskTitle = [self.viewModel returnTaskToEditTitle];
        
        [OSAlertController showDeleteTaskAlertOnController: self
                                             withTaskTitle: taskTitle
                                              withDelegate: self.viewModel];
    }
}

- (IBAction) onCreteOnBase: (UIButton*) sender
{
   // [self.viewModel storeNewTaskWithCompletion: nil];
}


#pragma mark - AddTaskViewModel delegate methods -

- (void) performSegueWithSegueId: (NSString*) segueId
{
    if ( segueId )
    {
        [self performSegueWithIdentifier: segueId
                                  sender: self];
    }
}

- (void) reloadAddTaskTableView
{
    [self.addTaskTableView reloadData];
}


#pragma mark - AddTaskModelDataSource methods -

- (AddTaskControllerType) getControllerType
{
    return [self.viewModel getControllerType];
}


#pragma mark - Internal methods -

- (UIView*) twoLineTitleView
{
    UIFont* customFont            = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 14.0f];
    UIFont* customFontForSubTitle = [UIFont fontWithName: @"SFUIText-Regular"
                                                    size: 13.0f];
    
    UILabel* titleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 0, 0, 0)];
    
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.textColor       = [UIColor whiteColor];
    titleLabel.font            = customFont;
    titleLabel.textAlignment   = NSTextAlignmentCenter;
    
    
    switch ([self getControllerType])
    {
        case AddNewTaskControllerType: titleLabel.text = @"НОВАЯ ЗАДАЧА";
            break;
            
        case AddSubtaskControllerType: titleLabel.text = @"НОВАЯ ПОДЗАДАЧА";
            break;
            
        case EditTaskControllerType: titleLabel.text = @"РЕДАКТИРОВАТЬ ЗАДАЧУ";
            break;
            
        default:
            break;
    }
    
    
    
    [titleLabel sizeToFit];
    
    UILabel* subTitleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 17, 0, 0)];
    
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor       = [UIColor whiteColor];
    subTitleLabel.font            = customFontForSubTitle;
    subTitleLabel.textAlignment   = NSTextAlignmentCenter;
    
    [subTitleLabel sizeToFit];
    
    UIView* twoLineTitleView = [[UIView alloc] initWithFrame: CGRectMake(0, 0, MAX(subTitleLabel.frame.size.width, titleLabel.frame.size.width), 32)];
    
    [twoLineTitleView addSubview: titleLabel];
    [twoLineTitleView addSubview: subTitleLabel];
    
    float widthDiff = subTitleLabel.frame.size.width - titleLabel.frame.size.width;
    
    if (widthDiff > 0)
    {
        CGRect frame     = titleLabel.frame;
        frame.origin.x   = widthDiff / 2;
        titleLabel.frame = CGRectIntegral(frame);
    }
    else
    {
        CGRect frame        = subTitleLabel.frame;
        frame.origin.x      = fabsf(widthDiff) / 2;
        subTitleLabel.frame = CGRectIntegral(frame);
    }
    
    self.navigationItem.titleView = twoLineTitleView;
    
    return twoLineTitleView;
}

- (void) setUpDefaults
{
    self.addTaskTableView.dataSource = self.viewModel;
    self.addTaskTableView.delegate   = self.viewModel;
   
    self.addTaskTableView.estimatedRowHeight = 100;
    self.addTaskTableView.rowHeight          = UITableViewAutomaticDimension;
    
    __weak typeof(self) blockSelf = self;
    
    [self.viewModel updateTeamInfoWithCompletion: ^(BOOL isSuccess) {
        
        [blockSelf.addTaskTableView reloadData];
        
    }];
    
    self.viewModel.reloadTableView = ^(){
        
        [blockSelf.addTaskTableView reloadData];
        
    };
    
    self.viewModel.performSegueWithID = ^(NSString* segueID) {
        
        [blockSelf performSegueWithIdentifier: segueID
                                       sender: blockSelf];
    };
}

- (void) bindUI
{
    self.readyBtn.rac_command               = self.viewModel.enableAllButtonsCommand;
    self.addTaskBtn.rac_command             = self.viewModel.enableAllButtonsCommand;
    self.addTaskAndCreateNewBtn.rac_command = self.viewModel.enableCreteOnBaseBtnCommand;
    self.createOnBaseBtn.rac_command        = self.viewModel.createOnExistingTaskBaseCommand;
    
    @weakify(self)
    
        [self.viewModel.enableCreteOnBaseBtnCommand.executionSignals subscribeNext: ^(RACSignal* signal)
         {
            [signal subscribeNext: ^(NSString* taskName) {
            
                @strongify(self)
                
                self.messageLabel.text = [NSString stringWithFormat: @"Задача %@ создана", taskName];
                
            }];
             
            [signal subscribeCompleted: ^{
                
                @strongify(self)
                
                [self showTaskCreatedMessage];
                
            }];
         }];

    
    [self.viewModel.createOnExistingTaskBaseCommand.executionSignals subscribeNext: ^(id x) {
        
        @strongify(self)
        
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName: @"TaskOptionsScreen"
                                                             bundle: nil];
        
        AddTaskViewController* addTaskController = [storyboard instantiateViewControllerWithIdentifier: @"AddTaskControllerID"];
        
        addTaskController.controllerType = AddNewTaskControllerType;
        
        [addTaskController fillTaskToEdit: [self.viewModel getSelectedTask]];
        
        addTaskController.addTaskBtn.hidden = NO;
        addTaskController.addTaskAndCreateNewBtn.hidden = NO;
        addTaskController.deleteTask.hidden = YES;
        addTaskController.createOnBaseBtn.hidden = YES;
        

        //actions for implementing completion after push
        [CATransaction begin];
        
        [self.navigationController pushViewController: addTaskController
                                             animated: YES];
        
        [CATransaction setCompletionBlock:^{
           
            [addTaskController.viewModel resetCellsContent];
        }];
        
        
    }];
    
    [self.viewModel.enableAllButtonsCommand.executionSignals subscribeNext: ^(RACSignal* signal) {
        
        [signal subscribeNext: ^(NSString* taskName) {
            
            @strongify(self)
            
            switch ([self getControllerType])
            {
                case AddNewTaskControllerType:
                {
                    self.messageLabel.text = [NSString stringWithFormat: @"Задача %@ создана", taskName];
                }
                    break;
                
                case AddSubtaskControllerType:
                {
                    self.messageLabel.text = [NSString stringWithFormat: @"Подзадача %@ создана",taskName];
                }
                    break;
                    
                default:
                    break;
            }
            
        }];
        
        [signal subscribeCompleted: ^{
            
            
            switch ([self getControllerType])
            {
                case AddSubtaskControllerType:
                case AddNewTaskControllerType:
                {
                    [self showTaskCreatedMessage];
                    
                    [self.viewModel storeNewTaskWithCompletion: ^(BOOL isSuccess) {
                        
                        [self dismissViewControllerAnimated: YES
                                                 completion: nil];
                    }];
                }
                    break;
                
                case EditTaskControllerType:
                {
                   //TODO: implement updating task according to changed task properties
                    
                    [self dismissViewControllerAnimated: YES
                                             completion: nil];
                }
                    
                default:
                    break;
            }
            
            
        }];
        
    }];
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.dismissTaskInfo = ^(){
        
        [blockSelf dismissViewControllerAnimated: YES
                                      completion:^{
                                          
                                          if ([blockSelf.delegate respondsToSelector: @selector(dismissTaskDetailAfterDeleting)])
                                          {
                                              [blockSelf.delegate dismissTaskDetailAfterDeleting];
                                          }
                                      }];
    };
   
}

- (void) showTaskCreatedMessage
{
    [UIView animateWithDuration: 2
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations: ^{
                         
                         self.messageView.hidden               = NO;
                         self.tableViewTopConstraint.constant  = 75;


                     }
                     completion: ^(BOOL finished) {
                         
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(4.0f * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             
                             [UIView animateWithDuration: 2
                                                   delay: 0
                                                 options: UIViewAnimationOptionCurveEaseIn
                                              animations: ^{
                                                  
                                                  self.tableViewTopConstraint.constant = 0;
                                                  self.messageView.hidden = YES;
                                                
                                              }
                                              completion: nil];
                             
                     });
    
                         
                     }];
}

- (void) changeUI
{
    self.view.backgroundColor             = [UIColor whiteColor];
    
    self.addTaskAndCreateNewBtn.hidden    = YES;
    self.deleteTask.hidden                = NO;
    
    self.addTaskBtn.hidden                = NO;
    self.createOnBaseBtn.hidden           = NO;
    
}


@end
