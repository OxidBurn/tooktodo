//
//  AddTaskViewModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskViewModel.h"

// Classes
#import "AddTaskModel.h"
#import "OSFlexibleTextFieldCell.h"
#import "ProjectsEnumerations.h"
#import "OSSwitchTableCell.h"
#import "RowContent.h"
#import "AddTaskMainFactory.h"


@interface AddTaskViewModel() <OSFlexibleTextFieldCellDelegate, AddTaskModelDelegate>

// properties
@property (strong, nonatomic) AddTaskModel* model;

@property (nonatomic, strong) UITableView* tableView;

// methods


@end


@implementation AddTaskViewModel 


#pragma mark - Initialization -

- (instancetype) init
{
    self = [super init];
    
    if ( self )
    {
        [self initialize];
    }
    
    return self;
}


#pragma mark - Properties -

- (AddTaskModel*) model
{
    if ( _model == nil )
    {
        _model = [AddTaskModel new];
        
        _model.delegate = self;
    }
    
    return _model;
}


#pragma mark - Public -

- (void) updateTeamInfoWithCompletion: (CompletionWithSuccess) completion
{
    [self.model updateTeamInfoWithCompletion: completion];
}

- (NSArray*) getAllMembersArray
{
    return [self.model getAllMembersArray];
}

- (NewTask*) getNewTask
{
    return [self.model returnNewTask];
}

- (AddTaskModel*) getModel
{
    return self.model;
}

- (void) storeNewTaskWithCompletion: (CompletionWithSuccess) completion
{
    [self.model storeNewTaskWithCompletion: completion];
}

- (NSArray*) returnAllSeguesArray
{
    return [self.model returnAllSeguesArray];
}

- (id) returnModel
{
    return self.model;
}

- (NSArray*) returnSelectedResponsibleArray
{
    return [self.model returnSelectedResponsibleArray];
}

- (NSArray*) returnSelectedClaimingArray
{
    return [self.model returnSelectedClaimingArray];
}

- (NSArray*) returnSelectedObserversArray
{
    return [self.model returnSelectedObserversArray];
}

- (TermsData*) returnTerms
{
    return [self.model returnTerms];
}

- (ProjectSystem*) returnSelectedSystem
{
    return [self.model returnSelectedSystem];
}

- (ProjectTaskStage*) returnSelectedStage
{
    return [self.model returnSelectedStage];
}

- (id) returnSelectedRoom
{
    return [self.model returnSelectedRoom];
}

- (TaskType) returnSelectedTaskType
{
    return [self.model returnSelectedTaskType];
}

- (NSString*) returnSelectedTaskTypeDesc
{
    return [self.model returnSelectedTaskTypeDesc];
}

- (NSString*) returnTaskName
{
    return [self.model returnTaskName];
}

- (void) fillDefaultStage: (ProjectTaskStage*) stage
           andHiddenState: (BOOL)              isHidden
{
    [self.model fillDefaultStage: stage
                  andHiddenState: isHidden];
}

- (void) fillControllerType: (AddTaskControllerType) controllerType
{
    [self.model fillControllerType: controllerType];
}

- (void) fillTaskToEdit: (ProjectTask*) taskToEdit
{
    [self.model fillTaskToEdit: taskToEdit];
}

- (AddTaskControllerType) getControllerType
{
    return [self.model getControllerType];
}

- (BOOL) checkSubtasks
{
   return [self.model checkSubtasks];
}

- (NSString*) returnTaskToEditTitle
{
    return [self.model returnTaskToEditTitle];
}

- (void) deselectAllRoomsInfo
{
    [self.model deselectAllRoomsInfo];
}

- (ProjectTask*) getSelectedTask
{
  return  [self.model getSelectedTask];
}

#pragma mark - UITableView data source -

- (NSInteger) numberOfSectionsInTableView: (UITableView*) tableView
{
    return 3;
}

- (NSInteger) tableView: (UITableView*) tableView
  numberOfRowsInSection: (NSInteger)    section
{
    return [self.model getNumberOfRowsForSection: section];
}

- (UITableViewCell*) tableView: (UITableView*) tableView
         cellForRowAtIndexPath: (NSIndexPath*) indexPath
{
    if (self.tableView == nil)
    {
        self.tableView = tableView;
    }
    
    id delegate;
    
    if ( indexPath.section == 0 && indexPath.row == 0 )
    {
        delegate = self;
    }
    else
        delegate = self.model;
    
    RowContent* content = [self.model getContentForIndexPath: indexPath];
    
    AddTaskMainFactory* factory = [AddTaskMainFactory new];
    
    UITableViewCell* cell = [factory createCellForTableView: tableView
                                                withContent: content
                                               withDelegate: delegate];

    return cell;
}

- (UIView*)  tableView: (UITableView*) tableView
viewForHeaderInSection: (NSInteger)    section
{
    switch ( section )
    {
        case 0:
            
            return nil;
            
            break;
            
        case 1 ... 2:
        {
            UIView* view = [[UIView alloc] initWithFrame: CGRectMake(0, 0, 20, 10)];
            
            view.backgroundColor = [UIColor lightGrayColor];
        }
            
            break;
            
        default:
            break;
    }
    
    return nil;
}

- (CGFloat)    tableView: (UITableView*) tableView
heightForHeaderInSection: (NSInteger)   section
{
    CGFloat height = 0;
    
    switch ( section )
    {
        case 1 ... 2:
            height = 10;
            
            break;
            
        default:
            break;
    }
    return height;
}


#pragma mark - UITableView delegate -

- (void)      tableView: (UITableView*) tableView
didSelectRowAtIndexPath: (NSIndexPath*) indexPath
{
    [tableView deselectRowAtIndexPath: indexPath
                             animated: YES];
    
    NSString* segueID = [self.model getSegueIdForIndexPath: indexPath];
    
    if ( [self.delegate respondsToSelector: @selector(performSegueWithSegueId:)] )
    {
        [self.delegate performSegueWithSegueId: segueID];
        
        if ( segueID == nil && indexPath.row != 0 )
            [SVProgressHUD showSuccessWithStatus: @"Раздел на этапе разработки"];
    }
    
    if ( indexPath.section == 0 )
    {
        switch ( indexPath.row )
        {
            case 0:
            {
                OSFlexibleTextFieldCell* cell = [tableView cellForRowAtIndexPath: indexPath];
            
                cell = (OSFlexibleTextFieldCell*)cell;
            
                cell.delegate = self;
            }
                break;
            
            
            default:
                break;
        }
    }
}

#pragma mark - OSFlexibleTextFieldDelegate methods -

- (void) updateFlexibleTextFieldCellWithText: (NSString*) newTaskNameString
{
    [self.model updateTaskNameWithString: newTaskNameString];
    
    if ( [self.delegate respondsToSelector: @selector(reloadAddTaskTableView)] )
        [self.delegate reloadAddTaskTableView];
}

- (AddTaskViewModel*) getViewModel
{
    return self;
}

- (void) updateFlexibleTextFieldCellFrame
{
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}

#pragma mark - AddTaskModelDelegate methods -

- (void) reloadData
{
    if ( self.reloadTableView )
        self.reloadTableView();
}

#pragma mark - Internal -

- (void) initialize
{
    self.enableConfirmButtons = [RACObserve (self, taskNameText)
                                 
                                 map: ^id (NSString* value) {
        
                                     return @([self.model isValidTaskName: value]);
        
                                 }] ;
    
    self.enableAllButtonsCommand = [[RACCommand alloc] initWithEnabled: self.enableConfirmButtons
                                                           signalBlock: ^RACSignal *(id input) {
    
                                                               __block NSString* taskName = @"";
                                                               
                                                               [self endEnteringTitleWithCompletion:^(BOOL isSuccess) {
                                                                   
                                                                    taskName = [self.model returnTaskName];
                                                               }];
                                                              
                                                               
                                                               return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                                                   
                                                                   [subscriber sendNext: taskName];
                                                                   [subscriber sendCompleted];
                                                                   
                                                                   return nil;
                                                               }];
                                                               
                                                           }];
    
    self.enableCreteOnBaseBtnCommand = [[RACCommand alloc] initWithEnabled: self.enableConfirmButtons
                                                               signalBlock: ^RACSignal *(id input) {
                                                                   
                                                                   NSString* taskName = [self.model returnTaskName];
                                                                   
                                                                   [self resetCellsContent];
                                                                   
                                                                   return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
                                                                       
                                                                       [subscriber sendNext: taskName];
                                                                       [subscriber sendCompleted];
                                                                       
                                                                       return nil;
                                                                   }];
                                                                   
                                                               }];
    
    self.createOnExistingTaskBaseCommand = [[RACCommand alloc] initWithSignalBlock: ^RACSignal *(id input) {
                
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            
            [subscriber sendNext: nil];
            [subscriber sendCompleted];
            
            return nil;
        }];
    }];
    
};


- (void) resetCellsContent
{
    OSFlexibleTextFieldCell* cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0
                                                                                              inSection: 0]];
    [cell resetCellContent];
    
    [cell makeTextViewFirstResponder];
    
    OSSwitchTableCell* switchCell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 2
                                                                                              inSection: 0]];
    [switchCell resetValue];
}

- (void) endEnteringTitleWithCompletion: (CompletionWithSuccess) completion
{
    OSFlexibleTextFieldCell* cell = [self.tableView cellForRowAtIndexPath: [NSIndexPath indexPathForRow: 0
                                                                                              inSection: 0]];
    
    [cell endTaskTitleEditingWithCompletion: completion];

}


#pragma mark - OS Alert delegate methods -

- (void) deleteTaskWithSubtasks: (BOOL) subtasks
{
    __weak typeof(self) blockSelf = self;
    
    [self.model deleteTaskWithSubtask: subtasks
                       withCompletion: ^(BOOL isSuccess) {
                           
                           if ( blockSelf.dismissTaskInfo )
                               blockSelf.dismissTaskInfo();
                           
                       }];
}

- (void) didDeleteTask
{
    [self deleteTaskWithSubtasks: NO];
}

@end
