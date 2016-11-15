//
//  AddTaskModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskModel.h"

// Classes
#import "ProjectsEnumerations.h"
#import "AddMessageViewController.h"
#import "SelectResponsibleViewController.h"
#import "AddTermTasksViewController.h"
#import "UserInfo+CoreDataProperties.h"
#import "FilledTeamInfo.h"
#import "ProjectTaskRoomLevel+CoreDataClass.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "SelectSystemViewController.h"
#import "SelectStageViewController.h"
#import "SelectRoomViewController.h"
#import "AddTaskTypeViewController.h"
#import "TasksService.h"
#import "OSSwitchTableCell.h"
#import "AddTaskContentManager.h"
#import "AddTaskContentManager+UpdadingContent.h"


@interface AddTaskModel() <AddMessageViewControllerDelegate,
                           OSSwitchTableCellDelegate,
                           SelectResponsibleViewControllerDelegate,
                           AddTaskTermsControllerDelegate,
                           SelectSystemViewControllerDelegate,
                           SelectStageViewControllerDelegate,
                           SelectRoomViewController,
                           AddTaskTypeDelegate>

// properties
@property (strong, nonatomic) NSArray* addTaskTableViewContent;

@property (nonatomic, strong) NewTask* task;

@property (strong, nonatomic) NSArray* allSeguesInfoArray;

@property (nonatomic, assign) AddTaskControllerType controllerType;

@property (strong, nonatomic) AddTaskContentManager* contentManager;

// methods


@end

@implementation AddTaskModel


#pragma mark - Properties -

- (AddTaskContentManager*) contentManager
{
    if ( _contentManager == nil )
    {
        _contentManager = [AddTaskContentManager new];
    }
    
    return _contentManager;
}

- (NSArray*) allSeguesInfoArray
{
    if ( _allSeguesInfoArray == nil )
    {
        _allSeguesInfoArray = @[@"ShowAddMassageController",
                                @"ShowSelectResponsibleController",
                                @"ShowSelectClaimingController",
                                @"ShowSelectObserversController",
                                @"ShowAddTermTaskController",
                                @"ShowStages",
                                @"ShowSystems",
                                @"ShowRooms",
                                @"ShowSelectingTaskInfoScreenID"];
    }
    
    return _allSeguesInfoArray;
}

- (NSArray*) addTaskTableViewContent
{
    if ( _addTaskTableViewContent == nil )
    {
        _addTaskTableViewContent = [self.contentManager getTableViewContentForNewTask];
    }
    
    return _addTaskTableViewContent;
}

- (NewTask*) task
{
    if ( _task == nil )
    {
        _task = [self.contentManager getNewTaskObject];
    }
    
    return _task;
}



#pragma mark - Public -

- (RowContent*) getContentForIndexPath: (NSIndexPath*) indexPath
{
    RowContent* content = self.addTaskTableViewContent[indexPath.section][indexPath.row];
    
    return content;
}

- (NSUInteger) getNumberOfRowsForSection: (NSUInteger) section;
{
    NSArray* sectionContent = self.addTaskTableViewContent[section];
    
    return sectionContent.count;
}

- (NSString*) getSegueIdForIndexPath: (NSIndexPath*) indexPath
{
    RowContent* content = self.addTaskTableViewContent[indexPath.section][indexPath.row];
    
    return content.segueId;
}

- (void) updateTaskNameWithString: (NSString*) newTaskName
{
    [self.contentManager updateTaskNameWithString: newTaskName];
}

- (NewTask*) returnNewTask
{
    return self.task;
}

- (NSArray*) returnAllSeguesArray
{
    return self.allSeguesInfoArray;
}

- (NSArray*) returnSelectedResponsibleArray
{
    return self.task.responsible;
}

- (NSArray*) returnSelectedClaimingArray
{
    return self.task.claiming;
}

- (NSArray*) returnSelectedObserversArray
{
    return self.task.observers;
}

- (TermsData*) returnTerms
{
    return self.task.terms;
}

- (ProjectSystem*) returnSelectedSystem
{
    return self.task.system;
}

- (ProjectTaskStage*) returnSelectedStage
{
    return self.task.stage;
}

- (id) returnSelectedRoom
{
    if ( self.task.level )
        return self.task.level;
    else
        return self.task.room;
}

- (TaskType) returnSelectedTaskType
{
    return self.task.taskType;
}

- (NSString*) returnSelectedTaskTypeDesc
{
    return self.task.taskDescription;
}

- (NSString*) returnTaskName
{
    return self.task.taskName;
}

- (void) storeNewTaskWithCompletion: (CompletionWithSuccess) completion
{
//    [[[TasksService sharedInstance] createNewTaskWithInfo: self.task]
//     subscribeNext: ^(id x) {
//         
//         if ( completion )
//             completion(YES);
//         
//     }
//     error: ^(NSError *error) {
//         
//         NSLog(@"<ERROR> Error with creation new task: %@", error.localizedDescription);
//         
//     }];
    
    [SVProgressHUD showErrorWithStatus: @"Создание задачи в процессе разработки!"];
    
    if ( completion )
        completion(YES);
}

- (void) fillDefaultStage: (ProjectTaskStage*) stage
           andHiddenState: (BOOL)              isHidden
{
  [self.contentManager fillDefaultStage: stage
                         andHiddenState: isHidden
                      forControllerType: self.controllerType];
}

- (void) fillControllerType: (AddTaskControllerType) controllerType
{
    self.controllerType = controllerType;
}


#pragma mark - OSSwitchTableCellDelegate methods -

- (void) updateTaskHiddenProperty: (BOOL) isHidden
{
    self.addTaskTableViewContent = [self.contentManager updateTaskHiddenProperty: isHidden];
}


#pragma mark - SelectResponsibleViewControllerDelegate methods -

- (void) returnSelectedResponsibleInfo: (NSArray*) selectedUsersArray
{
    self.addTaskTableViewContent = [self.contentManager updateSelectedResponsibleInfo: selectedUsersArray];
}

- (void) returnSelectedClaimingInfo: (NSArray*) selectedClaiming
{
    self.addTaskTableViewContent = [self.contentManager updateSelectedClaimingInfo: selectedClaiming];
}

- (void) returnSelectedObserversInfo: (NSArray*) selectedObservers
{
    self.addTaskTableViewContent = [self.contentManager updateSelectedObserversInfo: selectedObservers];
}


#pragma mark - SelectSystemViewControllerDelegate methods -

- (void) returnSelectedSystem: (ProjectSystem*) system
{
    [self.contentManager updateSelectedSystem: system];
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
        [self.delegate reloadData];
}


#pragma mark - SelectStagesViewControllerDelegate methods -

- (void) returnSelectedStage: (ProjectTaskStage*) stage
{
    [self.contentManager updateSelectedStage: stage];
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
        [self.delegate reloadData];
}


#pragma mark - SelectRoomViewControllerDelegate methods -


- (void) returnSelectedInfo: (id) info
{
    [self.contentManager updateSelectedInfo: info];
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
        [self.delegate reloadData];
}


#pragma mark - AddTaskTypeControllerDelegate methods-

- (void) didSelectedTaskType: (TaskType)  type
             withDescription: (NSString*) typeDescription
                   withColor: (UIColor*)  typeColor
{
    [self.contentManager updateSelectedTaskType: type
                                withDescription: typeDescription
                                      withColor: typeColor];
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
        [self.delegate reloadData];
}


#pragma mark - AddTaskTermsControllerDelegate methods -

- (void) updateTerms: (TermsData*) terms
{
    [self.contentManager updateTerms: terms];
}


#pragma mark - AddMessageViewControllerDelegate methods -

- (void) setTaskDescription: (NSString*) taskDescription
{
    [self.contentManager updateTaskDescription: taskDescription];
}


#pragma mark - Helpers -

- (BOOL) isValidTaskName: (NSString*) taskName
{
    return taskName.length > 0;
}

@end
