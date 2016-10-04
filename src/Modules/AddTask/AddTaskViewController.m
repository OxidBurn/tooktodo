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

@interface AddTaskViewController () <AddTaskViewModelDelegate>

// outlets

@property (weak, nonatomic) IBOutlet UIBarButtonItem* readyBtn;
@property (weak, nonatomic) IBOutlet UIButton*        addTaskAndCreateNewBtn;
@property (weak, nonatomic) IBOutlet UIButton*        addTaskBtn;
@property (weak, nonatomic) IBOutlet UITableView*     addTaskTableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelBtn;


// properties

@property (strong, nonatomic) AddTaskViewModel* viewModel;

// methods
- (IBAction) onAddAndCreateNewBtn: (UIButton*) sender;

- (IBAction) onAddTaskBtn:         (UIButton*) sender;

- (IBAction) onCancel:        (UIBarButtonItem*)sender;


@end

@implementation AddTaskViewController

#pragma mark - Life cycle -

- (void) loadView
{
    [super loadView];
    
    [self twoLineTitleView];
    
    [self setUpDefaults];
    
    [self bindUI];
}

- (void) viewDidLoad
{
    [super viewDidLoad];
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

#pragma mark - Actions -

- (IBAction) onAddAndCreateNewBtn: (UIButton*) sender
{
    
}

- (IBAction) onAddTaskBtn: (UIButton*) sender
{
    
}

- (IBAction) onCancel: (UIBarButtonItem*) sender
{
#warning  Make pop to previous vc
    
    
}

- (IBAction) onDismiss: (UIBarButtonItem*) sender
{
    [self dismissViewControllerAnimated: YES
                             completion: nil];
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
    self.addTaskAndCreateNewBtn.rac_command = self.viewModel.enableAllButtonsCommand;
    
    
    [self.viewModel.enableAllButtonsCommand.executionSignals subscribeNext: ^(RACSignal* signal) {
        
        [signal subscribeCompleted: ^{
            
                        NSLog(@"task saved somewhere");
            [self.viewModel getNewTask];
            
            NewTask* t = [self.viewModel getNewTask];
            NSLog(@" %@ %@ %i", t.taskName, t.taskDescription, t.isHiddenTask);
           // [self.navigationController popViewControllerAnimated: YES];
            
        }];
        
    }];
}

@end
