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
@property (nonatomic, assign) TaskControllerType controllerType;

// methods

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
//    
//    [self.viewModel getModel].dataSource = self;
}

- (void) viewWillAppear: (BOOL) animated
{
    [super viewWillAppear: animated];
    
    [self.addTaskTableView reloadData];
}

#pragma mark - Memory managment -

- (void) didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
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
            [controller updateControllerType: SelectResponsibleController
                                withDelegate: [self.viewModel returnModel]];
            [controller fillSelectedUsersInfo: [self.viewModel returnSelectedResponsibleArray]];
        }
            break;
            
        case ShowClaimingSegue:
        {
            SelectResponsibleViewController* controller = [segue destinationViewController];
            [controller updateControllerType: SelectClaimingController
                                withDelegate: [self.viewModel returnModel]];
            [controller fillSelectedUsersInfo: [self.viewModel returnSelectedClaimingArray]];
        }
            break;
            
        case ShowObserversSegue:
        {
            SelectResponsibleViewController* controller = [segue destinationViewController];
            [controller updateControllerType: SelectObserversController
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

- (void) fillControllerType: (TaskControllerType) controllerType
{
    [self.viewModel fillControllerType: controllerType];
}

#pragma mark - Actions -

- (IBAction) onAddAndCreateNewBtn: (UIButton*) sender
{
    [self.viewModel storeNewTaskWithCompletion: ^(BOOL isSuccess) {
        
        [self dismissViewControllerAnimated: YES
                                 completion: nil];
        
    }];

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
    
}

- (IBAction) onCreteOnBase: (UIButton*) sender
{
    
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

- (TaskControllerType) getControllerType
{
    return self.controllerType;
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
    titleLabel.text            = @"НОВАЯ ЗАДАЧА";
    [titleLabel sizeToFit];
    
    UILabel* subTitleLabel        = [[UILabel alloc] initWithFrame: CGRectMake(0, 17, 0, 0)];
    subTitleLabel.backgroundColor = [UIColor clearColor];
    subTitleLabel.textColor       = [UIColor whiteColor];
    subTitleLabel.font            = customFontForSubTitle;
    subTitleLabel.textAlignment   = NSTextAlignmentCenter;
    //    subTitleLabel.text            = [self.viewModel getProjectName];
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
    
    self.addTaskTableView.rowHeight = UITableViewAutomaticDimension;
    self.addTaskTableView.estimatedRowHeight = 42;
    
    __weak typeof(self) blockSelf = self;
    
    self.viewModel.reloadTableView = ^(){
        
        [blockSelf.addTaskTableView reloadData];
        
    };
}

- (void) bindUI
{
    self.readyBtn.rac_command               = self.viewModel.enableAllButtonsCommand;
    self.addTaskBtn.rac_command             = self.viewModel.enableAllButtonsCommand;
    self.addTaskAndCreateNewBtn.rac_command = self.viewModel.enableCreteOnBaseBtnCommand;
    
    
        [self.viewModel.enableCreteOnBaseBtnCommand.executionSignals subscribeNext:^(RACSignal* signal)
         {
            [signal subscribeNext: ^(NSString* taskName) {
                
            
                self.messageLabel.text = [NSString stringWithFormat: @"Задача %@ создана", taskName];
            
                
            }];
             
            [signal subscribeCompleted: ^{
                
    
                [self showTaskCreatedMessage];
            
                NewTask* t = [self.viewModel getNewTask];
                NSLog(@" %@ %@ %i", t.taskName, t.taskDescription, t.isHiddenTask);
                
          
            
            }];
         }];

    
    [self.viewModel.enableAllButtonsCommand.executionSignals subscribeNext: ^(RACSignal* signal) {
        
        [signal subscribeNext: ^(NewTask* task) {
            
            NewTask* t = task;
            NSLog(@" %@ %@ %i", t.taskName, t.taskDescription, t.isHiddenTask);
        }];
        
    }];
   
}

- (void) showTaskCreatedMessage
{
    [UIView animateWithDuration: 2
                          delay: 0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations: ^{
                         
                         [self changeUI];
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
    self.tableViewTopConstraint.constant  = 75;
    self.messageView.hidden               = NO;
    
    self.addTaskAndCreateNewBtn.hidden    = YES;
    self.deleteTask.hidden                = NO;
    
    self.addTaskBtn.hidden                = NO;
    self.createOnBaseBtn.hidden           = NO;
    
}


@end
