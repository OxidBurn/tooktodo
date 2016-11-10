//
//  AddTaskModel.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskModel.h"

// Factories
#import "OSRightDetailCellFactory.h"
#import "OSMarkedRightDetailCellFactory.h"
#import "OSSingleUserInfoCellFactory.h"
#import "OSGroupOfUsersInfoCellFactory.h"
#import "OSSwitchTableCellFactory.h"
#import "OSFlexibleTextCellFactory.h"
#import "OSFlexibleTextFieldCellFactory.h"
#import "OSSwitchTableCell.h"

// Classes
#import "ProjectsEnumerations.h"
#import "AddMessageViewController.h"
#import "SelectResponsibleViewController.h"
#import "AddTermTasksViewController.h"
#import "UserInfo+CoreDataProperties.h"
#import "DataManager+UserInfo.h"
#import "RowContent.h"
#import "NSDate+Helper.h"
#import "FilledTeamInfo.h"
#import "ProjectTaskRoomLevel+CoreDataClass.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "SelectSystemViewController.h"
#import "SelectStageViewController.h"
#import "SelectRoomViewController.h"
#import "AddTaskTypeViewController.h"
#import "Utils.h"
#import "TasksService.h"

typedef NS_ENUM(NSUInteger, AddTaskScreenSegueId) {
    
    ShowAddCommentSegueId,
    ShowTermsSegueID,
    ShowSelectResponsibleControllerSegueID,
    ShowSelectClaimingControllerSegueID,
    ShowSelectObserversControllerSegueID,
    ShowPremisesSegueID,
    ShowSelectStageSegueID,
    ShowSelectSystemSegueID,
    ShowSelectRoomSegueID,
    ShowAddTaskTypeSegueID,
};

typedef NS_ENUM(NSUInteger, RowsTypeSectionOne) {
    
    TaskNameRow,
    TaskDescriptionRow,
    TaskHiddenStatusRow,
    TaskResponsibleRow,
    TaskClaimingRow,
    TaskObserversRow
    
};

typedef NS_ENUM(NSUInteger, RowsTypeSectionTwo) {

    TaskTermsRow,
};

typedef NS_ENUM(NSUInteger, RowTypeSectionThree) {

    TaskPremisesRow,
    TaskTasksOnPlanRow,
    TaskStageRow,
    TaskSystemRow,
    TaskTypeRow,
    TaskDocumentsRow,
    
};

@interface AddTaskModel() <AddMessageViewControllerDelegate, OSSwitchTableCellDelegate, SelectResponsibleViewControllerDelegate, AddTaskTermsControllerDelegate, SelectSystemViewControllerDelegate, SelectStageViewControllerDelegate, SelectRoomViewController, AddTaskTypeDelegate>

// properties
@property (strong, nonatomic) NSArray* addTaskTableViewContent;

@property (strong, nonatomic) NSArray* addTaskTableViewCellsInfo;

@property (strong, nonatomic) NSArray* addTaskTableViewSeguesInfo;

@property (nonatomic, strong) NewTask* task;

@property (strong, nonatomic) NSArray* allSeguesInfoArray;

@property (nonatomic, assign) TaskControllerType controllerType;


// methods


@end

@implementation AddTaskModel

#pragma mark - Properties -

- (NSArray*) addTaskTableViewCellsInfo
{
    if ( _addTaskTableViewCellsInfo == nil )
    {
        _addTaskTableViewCellsInfo = @[@"FlexibleTextFieldCellID", @"FlexibleTextCellID", @"RightDetailCellID", @"SwitchCellID", @"SingleUserInfoCellID", @"GroupOfUsersCellID", @"MarkedRightDetailsCellID"];
    }
    
    return _addTaskTableViewCellsInfo;
}

- (NSArray*) addTaskTableViewSeguesInfo
{
    if ( _addTaskTableViewSeguesInfo == nil )
    {
        _addTaskTableViewSeguesInfo = @[@"ShowAddMassageController", @"ShowAddTermTaskController", @"ShowSelectResponsibleController", @"ShowSelectClaimingController", @"ShowSelectObserversController", @"ShowSelectionPremisesController", @"ShowStages", @"ShowSystems", @"ShowRooms", @"ShowSelectingTaskInfoScreenID"];
    }
    
    return _addTaskTableViewSeguesInfo;
}

- (NSArray*) allSeguesInfoArray
{
    if ( _allSeguesInfoArray == nil )
    {
        _allSeguesInfoArray = @[@"ShowAddMassageController", @"ShowSelectResponsibleController", @"ShowSelectClaimingController", @"ShowSelectObserversController", @"ShowAddTermTaskController", @"ShowStages", @"ShowSystems", @"ShowRooms", @"ShowSelectingTaskInfoScreenID"];
    }
    
    return _allSeguesInfoArray;
}

- (NSArray*) addTaskTableViewContent
{
    if ( _addTaskTableViewContent == nil )
    {
        _addTaskTableViewContent = [self createTableViewContent];
    }
    
    return _addTaskTableViewContent;
}

- (NewTask*) task
{
    if (_task == nil)
    {
        _task = [NewTask new];
        
        _task.defaultResponsible = [self getCurrentUserInfoArray];
        
        if ( _task.responsible == nil )
        {
            _task.responsible = _task.defaultResponsible;
        }

    }
    
    return _task;
}


#pragma mark - Public -


- (NSUInteger) getNumberOfRowsForSection: (NSUInteger) section;
{
    return [self.addTaskTableViewContent[section] count];
}

- (UITableViewCell*) createCellForTableView: (UITableView*) tableView
                               forIndexPath: (NSIndexPath*) indexPath
{
    NSArray* section = self.addTaskTableViewContent[indexPath.section];
    
    RowContent* content = section[indexPath.row];
    
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    
    NSString* cellID = content.cellId;
    
    NSUInteger cellTypeIndex = [self.addTaskTableViewCellsInfo indexOfObject: cellID];
    
    switch ( cellTypeIndex )
    {
        case FlexibleTextFieldCell:
        {
            OSFlexibleTextFieldCellFactory* factory = [OSFlexibleTextFieldCellFactory new];
            
            cell = [factory returnFlexibleTextFieldCellWithTextContent: content.title
                                                          forTableView: tableView];
        }
            break;
            
        case RightDetailCell:
        {
            OSRightDetailCellFactory* factory = [OSRightDetailCellFactory new];
            
            cell = [factory returnRightDetailCellWithTitle: content.title
                                            withDetailText: content.detail
                                              forTableView: tableView];
            
        }
            break;
            
        case FlexibleCell:
        {
            OSFlexibleTextCellFactory* factory = [OSFlexibleTextCellFactory new];
            
            cell = [factory returnFlexibleCellWithTextContent: content.title
                                                 forTableView: tableView];
            
            
        }
            break;
            
        case SwitchCell:
        {
            OSSwitchTableCellFactory* factory = [OSSwitchTableCellFactory new];
            
            BOOL stateBoolValue = content.isHidden;
            
            cell = [factory returnSwitchCellWithTitle: content.title
                                              withTag: AddTaskIsHiddenTaskSwitchTag
                                      withSwitchState: stateBoolValue
                                         forTableView: tableView
                                         withDelegate: self
                                     withEnabledState: [self handleEnabledSwitchStateForContent: content]];
        }
            break;
            
        case SingleUserInfoCell:
        {
            OSSingleUserInfoCellFactory* factory = [OSSingleUserInfoCellFactory new];
            
            FilledTeamInfo* user = content.membersArray[0];
            
            NSString* userFullName  = user.fullname;
            
            NSString* userAvatarSrc = user.avatarSrc;
            
            cell = [factory returnSingleUserCellWithTitle: content.title
                                         withUserFullName: userFullName
                                           withUserAvatar: userAvatarSrc
                                             forTableView: tableView];
        }
            break;
            
        case GroupOfUsersCell:
        {
            OSGroupOfUsersInfoCellFactory* factory = [OSGroupOfUsersInfoCellFactory new];
            
            cell = [factory returnGroupOfUsersCellWithTitle: content.title
                                             withUsersArray: content.membersArray
                                               forTableView: tableView];

        }
            break;
            
        case MarkedRightDetailCell:
        {
            OSMarkedRightDetailCellFactory* factory = [OSMarkedRightDetailCellFactory new];

            cell = [factory returnMarkedRightDetailCellWithTitle: content.title
                                                  withDetailText: content.detail
                                                   withMarkImage: content.markImage
                                                    forTableView: tableView];
        }
            break;
            
        default:
            break;
    }
    
    if (content.userInteractionEnabled == NO)
    {
        cell.userInteractionEnabled = NO;
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    return cell;
}

- (NSString*) getSegueIdForIndexPath: (NSIndexPath*) indexPath
{
    RowContent* content = self.addTaskTableViewContent[indexPath.section][indexPath.row];
    
    return content.segueId;
}

- (void) updateTaskNameWithString: (NSString*) newTaskName
{
    self.task.taskName = newTaskName;
    
    if ( [newTaskName isEqualToString: @""] )
    {
        newTaskName = @"Название задачи ";
    }
    
    RowContent* newRow = self.addTaskTableViewContent[SectionOne][TaskNameRow];
    
    newRow.title  = newTaskName;
    
    [self updateContentWithRow: newRow
                     inSection: SectionOne
                         inRow: TaskNameRow];
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
    self.task.isHiddenTask = isHidden;
    self.task.stage        = stage;
    
    RowContent* rowHiddenTsk = self.addTaskTableViewContent[SectionOne][TaskHiddenStatusRow];
    
    rowHiddenTsk.isHidden = isHidden;
    
    [self updateContentWithRow: rowHiddenTsk
                     inSection: SectionOne
                         inRow: TaskHiddenStatusRow];
    
    RowContent* rowStage = self.addTaskTableViewContent[SectionThree][TaskStageRow];
    
    rowStage.detail = stage.title;
    
    [self disableUserInteractionForStage];
 
    [self updateContentWithRow: rowStage
                     inSection: SectionThree
                         inRow: TaskStageRow];
    
}

- (void) fillControllerType: (TaskControllerType) controllerType
{
    self.controllerType = controllerType;
}

- (void) disableUserInteractionForStage
{
    RowContent* rowStage = self.addTaskTableViewContent[SectionThree][TaskStageRow];
    
    switch (self.controllerType)
    {
        case AddTaskControllerType:
        {
            rowStage.userInteractionEnabled = YES;
            break;
        }
            
        case AddSubtaskControllerType:
        {
            rowStage.userInteractionEnabled = NO;
            break;
        }
            
        default:
            break;
    }
}

#pragma mark - OSSwitchTableCellDelegate methods -

- (void) updateTaskHiddenProperty: (BOOL) isHidden
{
    self.task.isHiddenTask = isHidden;
    
    RowContent* newRow = self.addTaskTableViewContent[SectionOne][TaskHiddenStatusRow];
    
    newRow.isHidden = isHidden;
    
    [self updateContentWithRow: newRow inSection: SectionOne inRow: TaskHiddenStatusRow];
}

#pragma mark - SelectResponsibleViewControllerDelegate methods -

- (void) returnSelectedResponsibleInfo: (NSArray*) selectedUsersArray
{
    self.task.responsible = selectedUsersArray;
    
    RowContent* row = self.addTaskTableViewContent[SectionOne][TaskResponsibleRow];
    
    row.membersArray = selectedUsersArray;
    
    [self updateContentWithRow: row inSection: SectionOne inRow: TaskResponsibleRow];
    
}

- (void) returnSelectedClaimingInfo: (NSArray*) selectedClaiming
{
    self.task.claiming = selectedClaiming;
    
    RowContent* row = self.addTaskTableViewContent[SectionOne][TaskClaimingRow];
    
    if ( selectedClaiming )
    {
        row.cellId = self.addTaskTableViewCellsInfo[GroupOfUsersCell];
    }
    
    row.membersArray = selectedClaiming;
    
    row.cellId = [self determineCellIdForContent: selectedClaiming];
    
    if ( selectedClaiming.count == 0 )
        row.detail = @"Не выбраны";
    
    [self updateContentWithRow: row inSection: SectionOne inRow: TaskClaimingRow];
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
    {
        [self.delegate reloadData];
    }
    
}

- (void) returnSelectedObserversInfo: (NSArray*) selectedObservers
{
    self.task.observers = selectedObservers;
    
    RowContent* row = self.addTaskTableViewContent[SectionOne][TaskObserversRow];
    
    row.membersArray = selectedObservers;
    
    row.cellId = [self determineCellIdForContent: selectedObservers];
    
    [self updateContentWithRow: row inSection: SectionOne inRow: TaskObserversRow];
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
    {
        [self.delegate reloadData];
    }

}


#pragma mark - SelectSystemViewControllerDelegate methods -

- (void) returnSelectedSystem: (ProjectSystem*) system
{
    self.task.system = system;
    
    RowContent* row = self.addTaskTableViewContent[SectionThree][TaskSystemRow];
    
    if (system)
    {
        row.cellId = self.addTaskTableViewCellsInfo[RightDetailCell];
        row.detail = system.title;
    }
    else
    {
        row.detail = @"Не выбрано";
    }
    
    
    [self updateContentWithRow: row
                     inSection: SectionThree
                         inRow: TaskSystemRow];
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
    {
        [self.delegate reloadData];
    }
}


#pragma mark - SelectStagesViewControllerDelegate methods -

- (void) returnSelectedStage: (ProjectTaskStage*) stage
{
    self.task.stage = stage;
    
    RowContent* row = self.addTaskTableViewContent[SectionThree][TaskStageRow];
    
    if (stage)
    {
        row.cellId = self.addTaskTableViewCellsInfo[RightDetailCell];
        row.detail = stage.title;
    }
    else
    {
        row.detail = @"Не выбрано";
    }
    
    
    [self updateContentWithRow: row
                     inSection: SectionThree
                         inRow: TaskStageRow];
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
    {
        [self.delegate reloadData];
    }
}

#pragma mark - SelectRoomViewControllerDelegate methods -


- (void) returnSelectedInfo: (id) info
{
    ProjectTaskRoomLevel* levelItem = nil;
    ProjectTaskRoom*      roomItem = nil;
    
    //Check which info comes
    if ([info isKindOfClass:[ProjectTaskRoom class]])
    {
        roomItem       = info;
        self.task.room = (ProjectTaskRoom*)roomItem;
    }
    else
        if ([info isKindOfClass:[ProjectTaskRoomLevel class]])
        {
            levelItem = info;
            self.task.level = (ProjectTaskRoomLevel*)levelItem;
        }
    
    RowContent* row = self.addTaskTableViewContent[SectionThree][TaskPremisesRow];
    
    if (roomItem)
    {
        row.cellId = self.addTaskTableViewCellsInfo[RightDetailCell];
        row.detail = roomItem.title;
    }
    
    else if (levelItem)
    {
        row.cellId = self.addTaskTableViewCellsInfo[RightDetailCell];
        row.detail = [NSString stringWithFormat: @"Уровень %@", levelItem.level];
    }
    
    else
    {
        row.cellId = self.addTaskTableViewCellsInfo[RightDetailCell];
        row.detail = info;
    }
    
    [self updateContentWithRow: row
                     inSection: SectionThree
                         inRow: TaskPremisesRow];
    
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
    {
        [self.delegate reloadData];
    }
}

#pragma mark - AddTaskTypeControllerDelegate methods-

- (void) didSelectedTaskType: (TaskType)  type
             withDescription: (NSString*) typeDescription
                   withColor: (UIColor*)  typeColor
{
    self.task.taskType = type;
    self.task.typeDescription = typeDescription;
    
    RowContent* row = self.addTaskTableViewContent[SectionThree][TaskTypeRow];
    
    row.cellId = self.addTaskTableViewCellsInfo[MarkedRightDetailCell];
    row.markImage = typeColor;
    row.detail = typeDescription;
    
    [self updateContentWithRow: row
                     inSection: SectionThree
                         inRow: TaskTypeRow];
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
    {
        [self.delegate reloadData];
    }
}

#pragma mark - AddTaskTermsControllerDelegate methods -

- (void) updateTerms: (TermsData*) terms
{
    self.task.terms.startDate  = terms.startDate;
    self.task.terms.endDate    = terms.endDate;
    self.task.terms.duration   = terms.duration;
    
    RowContent* row = self.addTaskTableViewContent[SectionTwo][TaskTermsRow];
    
    row.detail = [self createTermsLabelTextForStartDate: terms.startDate
                                         withFinishDate: terms.endDate
                                           withDuration: terms.duration];
}


#pragma mark - Internal -

- (BOOL) handleEnabledSwitchStateForContent: (RowContent*) rowContent
{

    switch (self.controllerType)
    {
        case AddTaskControllerType:
        {
            rowContent.isSwitchEnabled = YES;
            break;
        }
         
        case AddSubtaskControllerType:
        {
            rowContent.isSwitchEnabled = NO;
            break;
        }
            
        default:
            break;
    }
    
    return rowContent.isSwitchEnabled;
}

- (NSArray*) createTableViewContent
{
    NSArray* sectionOne   = [self createSectionOne];
    
    NSArray* sectionTwo   = [self createSectionTwo];
    
    NSArray* sectionThree = [self createSectionThree];
    
    return [NSArray arrayWithObjects: sectionOne, sectionTwo, sectionThree, nil];
}

- (NSArray*) createSectionOne
{
    RowContent* rowOne = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowOne.cellId = self.addTaskTableViewCellsInfo[FlexibleTextFieldCell];
    rowOne.title  = self.task.taskName ? self.task.taskName : @"Название задачи";
    
    RowContent* rowTwo = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowTwo.cellId  = self.addTaskTableViewCellsInfo[FlexibleCell];
    rowTwo.title   = self.task.taskDescription ? self.task.taskDescription : @"Описание задачи";
    rowTwo.segueId = self.addTaskTableViewSeguesInfo[ShowAddCommentSegueId];
    
    RowContent* rowThree = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowThree.cellId   = self.addTaskTableViewCellsInfo[SwitchCell];
    rowThree.title    = @"Скрытая задача";
    rowThree.isHidden = self.task.isHiddenTask? self.task.isHiddenTask : NO;
    
    RowContent* rowFour = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowFour.cellId       = self.addTaskTableViewCellsInfo[SingleUserInfoCell];
    rowFour.title        = @"Ответственный";
    rowFour.membersArray = self.task.responsible? self.task.responsible : self.task.defaultResponsible;
    rowFour.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectResponsibleControllerSegueID];
    
    
    RowContent* rowFive = [[RowContent alloc] initWithUserInteractionEnabled];
    
    NSString* cellForRowFiveId = [self determineCellIdForGroupOfMembers: self.task.claiming];
    
    NSString* cellFiveDetailText  = [cellForRowFiveId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"Не выбраны" : @"";
    
    rowFive.cellId       = cellForRowFiveId;
    rowFive.title        = @"Утверждающие";
    rowFive.detail       = cellFiveDetailText;
    rowFive.membersArray = self.task.claiming;
    rowFive.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectClaimingControllerSegueID];
    
    RowContent* rowSix = [[RowContent alloc] initWithUserInteractionEnabled];
    
    NSString* cellForRowSixId = [self determineCellIdForGroupOfMembers: self.task.observers];
    
    NSString* cellSixDetailText  = [cellForRowSixId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"Не выбраны" : @"";
    
    rowSix.cellId       = cellForRowSixId;
    rowSix.title        = @"Наблюдатели";
    rowSix.detail       = cellSixDetailText;
    rowSix.membersArray = self.task.observers;
    rowSix.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectObserversControllerSegueID];
    
    return @[ rowOne, rowTwo, rowThree, rowFour, rowFive, rowSix ];
}

- (NSArray*) createSectionTwo
{
    RowContent* row = [[RowContent alloc] initWithUserInteractionEnabled];
    
    row.title   = @"Сроки";
    row.detail  = [self createTermsLabelTextForStartDate: self.task.terms.startDate
                                          withFinishDate: self.task.terms.endDate
                                            withDuration: self.task.terms.duration];
    
    row.cellId  = self.addTaskTableViewCellsInfo[RightDetailCell];
    row.segueId = self.addTaskTableViewSeguesInfo[ShowTermsSegueID];
    
    return @[ row ];
}

- (NSArray*) createSectionThree
{
    RowContent* rowOne = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowOne.title   = @"Помещение";
    rowOne.detail  = @"Не выбрано";
    rowOne.cellId  = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowOne.segueId = self.addTaskTableViewSeguesInfo[ShowSelectRoomSegueID];
    
    RowContent* rowTwo = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowTwo.title  = @"Задача на плане";
    rowTwo.detail = @"Не реализовано";
    rowTwo.cellId = self.addTaskTableViewCellsInfo[RightDetailCell];
    
    RowContent* rowThree = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowThree.title   = @"Этап";
    rowThree.detail  = @"Не реализовано";
    rowThree.cellId  = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowThree.segueId = self.addTaskTableViewSeguesInfo[ShowSelectStageSegueID];

    
    RowContent* rowFour = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowFour.title   = @"Система";
    rowFour.detail  = @"Не реализовано";
    rowFour.cellId  = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowFour.segueId = self.addTaskTableViewSeguesInfo[ShowSelectSystemSegueID];
    
    RowContent* rowFive = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowFive.title         = @"Тип задачи";
    rowFive.detail        = @"Не реализовано";
    rowFive.markImage     = [UIColor colorWithRed:0.310 green:0.773 blue:0.176 alpha:1.000];
    rowFive.cellId        = self.addTaskTableViewCellsInfo[MarkedRightDetailCell];
    rowFive.segueId       = self.addTaskTableViewSeguesInfo[ShowAddTaskTypeSegueID];
    
    RowContent* rowSix = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowSix.title  = @"Документы к задаче";
    rowSix.detail = @"Не реализовано";
    rowSix.cellId = self.addTaskTableViewCellsInfo[RightDetailCell];
    
    return @[ rowOne, rowTwo, rowThree, rowFour, rowFive, rowSix ];
}


#pragma mark - AddMessageViewControllerDelegate methods -

- (void) setTaskDescription: (NSString*) taskDescription
{
    self.task.taskDescription = taskDescription;
    
    RowContent* newRow = self.addTaskTableViewContent[0][1];
    
    newRow.title = taskDescription;
    
    if ( [taskDescription isEqualToString: @"Введите описание задачи"] )
    {
        taskDescription = @"";
    }
    
    [self updateContentWithRow: newRow
                     inSection: SectionOne
                         inRow: TaskDescriptionRow];
}

#pragma mark - Helpers -

- (NSString*) determineCellIdForGroupOfMembers: (NSArray*) membersGroup
{
    NSString* cellID = [NSString new];
    
    if ( membersGroup.count == 0 )
    {
        cellID = self.addTaskTableViewCellsInfo[RightDetailCell];
    } else
        if ( membersGroup.count == 1 )
        {
            cellID = self.addTaskTableViewCellsInfo[SingleUserInfoCell];
        } else
        {
            cellID = self.addTaskTableViewCellsInfo[GroupOfUsersCell];
        }
    
    return cellID;
}

- (NSString*) createTermsLabelTextForStartDate: (NSDate*) startDate
                                withFinishDate: (NSDate*) finishDate
                                  withDuration: (NSUInteger) duration
{
    NSString* labelText;
    
    if ( startDate && finishDate )
    {
        NSString* firstDate = [NSDate stringFromDate: startDate withFormat: @"dd.MM"];
        
        NSString* secondDate = [NSDate stringFromDate: finishDate withFormat: @"dd.MM.yyyy"];
        
        labelText = [NSString stringWithFormat: @"%@ - %@, %@", firstDate, secondDate, [Utils generateStringOfDaysCount: duration]];
    } else
    {
        labelText = @"Не выбраны";
    }
    
    return labelText;
}

- (BOOL) isValidTaskName: (NSString*) taskName
{
    return taskName.length > 0;
}

- (NSArray*) getCurrentUserInfoArray
{
    NSArray* allUsers = [[DataManager sharedInstance] getAllUserInfo];
    
    UserInfo* userInfo = [allUsers firstObject];
    
    FilledTeamInfo* teamInfo = [FilledTeamInfo new];
    
    [teamInfo convertUserToTeamInfo: userInfo];
    
    teamInfo.isResponsible = YES;
    
    return teamInfo? @[teamInfo] : nil;
}

- (void) updateContentWithRow: (RowContent*) newRow
                    inSection: (NSUInteger) section
                        inRow: (NSUInteger) row
{
    NSArray* sectionContent = self.addTaskTableViewContent[section];
    
    NSMutableArray* contentCopy = [NSMutableArray arrayWithArray: self.addTaskTableViewContent];
    
    NSMutableArray* sectionCopy = [NSMutableArray arrayWithArray: sectionContent];
    
    [sectionCopy replaceObjectAtIndex: row withObject: newRow];
    
    sectionContent = [sectionCopy copy];
    
    [contentCopy replaceObjectAtIndex: section withObject: sectionContent];
    
    self.addTaskTableViewContent = [contentCopy copy];
}

- (NSString*) determineCellIdForContent: (NSArray*) arrayToCheck
{
    NSString* cellId;
    
    if ( arrayToCheck == nil || arrayToCheck.count == 0 )
    {
        cellId = self.addTaskTableViewCellsInfo[RightDetailCell];
    } else
        if ( arrayToCheck.count == 1 )
        {
            cellId = self.addTaskTableViewCellsInfo[SingleUserInfoCell];
        } else
            cellId = self.addTaskTableViewCellsInfo[GroupOfUsersCell];
    
    return cellId;
}

@end
