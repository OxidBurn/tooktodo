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

typedef NS_ENUM(NSUInteger, AddTaskScreenSegueId) {
    
    ShowAddCommentSegueId,
    ShowTermsSegueID,
    ShowSelectResponsibleControllerSegueID,
    ShowSelectClaimingControllerSegueID,
    ShowSelectObserversControllerSegueID,
    ShowPremisesSegueID,
    ShowSelectStageSegueID,
    ShowSelectSystemSegueID,
    
};

@interface AddTaskModel() <AddMessageViewControllerDelegate, OSSwitchTableCellDelegate, SelectResponsibleViewControllerDelegate, AddTaskTermsControllerDelegate>

// properties
@property (strong, nonatomic) NSArray* addTaskTableViewContent;

@property (strong, nonatomic) NSArray* addTaskTableViewCellsInfo;

@property (strong, nonatomic) NSArray* addTaskTableViewSeguesInfo;

@property (nonatomic, strong) NewTask* task;

@property (strong, nonatomic) NSArray* allSeguesInfoArray;


// methods


@end

@implementation AddTaskModel

#pragma mark - Properties -

- (NSArray*) addTaskTableViewCellsInfo
{
    if ( _addTaskTableViewCellsInfo == nil )
    {
        _addTaskTableViewCellsInfo = @[@"FlexibleTextFieldCellID", @"FlexibleTextCellID", @"RightDetailCellID", @"SwitchCellID", @"SingleUserInfoCellID", @"GroupOfUsersCellID", @"MarkedRightDetailsCellID" ];
    }
    
    return _addTaskTableViewCellsInfo;
}

- (NSArray*) addTaskTableViewSeguesInfo
{
    if ( _addTaskTableViewSeguesInfo == nil )
    {
        _addTaskTableViewSeguesInfo = @[@"ShowAddMassageController", @"ShowAddTermTaskController", @"ShowSelectResponsibleController", @"ShowSelectClaimingController", @"ShowSelectObserversController", @"ShowSelectionPremisesController", @"ShowStages", @"ShowSystems"];
    }
    
    return _addTaskTableViewSeguesInfo;
}

- (NSArray*) allSeguesInfoArray
{
    if ( _allSeguesInfoArray == nil )
    {
        _allSeguesInfoArray = @[@"ShowAddMassageController", @"ShowSelectResponsibleController", @"ShowSelectClaimingController", @"ShowSelectObserversController", @"ShowAddTermTaskController", @"ShowStages", @"ShowSystems"];
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
                                      withSwitchState: stateBoolValue
                                         forTableView: tableView
                                         withDelegate: self];
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
                                                   withMarkImage: [UIImage imageNamed: content.markImageName]
                                                    forTableView: tableView];
        }
            break;
            
        default:
            break;
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
        newTaskName = @"Название задачи";
    }
    
    RowContent* newRow = self.addTaskTableViewContent[0][0];
    
    newRow.title  = newTaskName;
    
    [self updateContentWithRow: newRow
                     inSection: 0
                         inRow: 0];
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

#pragma mark - OSSwitchTableCellDelegate methods -

- (void) updateTaskState: (BOOL) isHidden
{
    self.task.isHiddenTask = isHidden;
    
    RowContent* newRow = self.addTaskTableViewContent[0][2];
    
    newRow.isHidden = isHidden;
    
    [self updateContentWithRow: newRow inSection: 0 inRow: 2];
}

#pragma mark - SelectResponsibleViewControllerDelegate methods -

- (void) returnSelectedResponsibleInfo: (NSArray*) selectedUsersArray
{
    self.task.responsible = selectedUsersArray;
    
    RowContent* row = self.addTaskTableViewContent[0][3];
    
    row.membersArray = selectedUsersArray;
    
    [self updateContentWithRow: row inSection: 0 inRow: 3];
}

- (void) returnSelectedClaimingInfo: (NSArray*) selectedClaiming
{
    self.task.claiming = selectedClaiming;
    
    RowContent* row = self.addTaskTableViewContent[0][4];
    
    if ( selectedClaiming )
    {
        row.cellId = self.addTaskTableViewCellsInfo[GroupOfUsersCell];
    }
    
    row.membersArray = selectedClaiming;
    
    [self updateContentWithRow: row inSection: 0 inRow: 4];
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
    {
        [self.delegate reloadData];
    }
}

- (void) returnSelectedObserversInfo: (NSArray*) selectedObservers
{
    self.task.observers = selectedObservers;
    
    RowContent* row = self.addTaskTableViewContent[0][5];
    
    if ( selectedObservers )
    {
        row.cellId = self.addTaskTableViewCellsInfo[GroupOfUsersCell];
    }
    
    row.membersArray = selectedObservers;
    
    [self updateContentWithRow: row inSection: 0 inRow: 5];
    
    if ( [self.delegate respondsToSelector: @selector( reloadData )] )
    {
        [self.delegate reloadData];
    }
}


#pragma mark - AddTaskTermsControllerDelegate methods -

- (void) updateTermsWithStartDate: (NSDate*)    startDate
                    andFinishDate: (NSDate*)    finishDate
                     withDuration: (NSUInteger) duration
{
    self.task.startDate  = startDate;
    self.task.finishDate = finishDate;
    self.task.duration   = duration;
    
    RowContent* row = self.addTaskTableViewContent[1][0];
    
    row.detail = [self createTermsLabelTextForStartDate: startDate
                                         withFinishDate: finishDate
                                           withDuration: duration];
}


#pragma mark - Internal -

- (NSArray*) createTableViewContent
{
    NSArray* sectionOne   = [self createSectionOne];
    
    NSArray* sectionTwo   = [self createSectionTwo];
    
    NSArray* sectionThree = [self createSectionThree];
    
    return [NSArray arrayWithObjects: sectionOne, sectionTwo, sectionThree, nil];
}

- (NSArray*) createSectionOne
{
    RowContent* rowOne = [RowContent new];
    
    rowOne.cellId = self.addTaskTableViewCellsInfo[FlexibleTextFieldCell];
    rowOne.title  = self.task.taskName ? self.task.taskName : @"Название задачи";
    
    RowContent* rowTwo = [RowContent new];
    
    rowTwo.cellId  = self.addTaskTableViewCellsInfo[FlexibleCell];
    rowTwo.title   = self.task.taskDescription ? self.task.taskDescription : @"Описание задачи";
    rowTwo.segueId = self.addTaskTableViewSeguesInfo[ShowAddCommentSegueId];
    
    RowContent* rowThree = [RowContent new];
    
    rowThree.cellId   = self.addTaskTableViewCellsInfo[SwitchCell];
    rowThree.title    = @"Скрытая задача";
    rowThree.isHidden = self.task.isHiddenTask? self.task.isHiddenTask : NO;
    
    RowContent* rowFour = [RowContent new];
    
    rowFour.cellId       = self.addTaskTableViewCellsInfo[SingleUserInfoCell];
    rowFour.title        = @"Ответственный";
    rowFour.membersArray = self.task.responsible? self.task.responsible : self.task.defaultResponsible;
    rowFour.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectResponsibleControllerSegueID];
    
    RowContent* rowFive = [RowContent new];
    
    NSString* cellForRowFiveId = [self determineCellIdForGroupOfMembers: self.task.claiming];
    
    NSString* cellFiveDetailText  = [cellForRowFiveId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"Не выбрано" : @"";
    
    rowFive.cellId       = cellForRowFiveId;
    rowFive.title        = @"Утверждающие";
    rowFive.detail       = cellFiveDetailText;
    rowFive.membersArray = self.task.claiming;
    rowFive.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectClaimingControllerSegueID];
    
    RowContent* rowSix = [RowContent new];
    
    NSString* cellForRowSixId = [self determineCellIdForGroupOfMembers: self.task.observers];
    
    NSString* cellSixDetailText  = [cellForRowSixId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"Не выбрано" : @"";
    
    rowSix.cellId       = cellForRowSixId;
    rowSix.title        = @"Наблюдатели";
    rowSix.detail       = cellSixDetailText;
    rowSix.membersArray = self.task.observers;
    rowSix.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectObserversControllerSegueID];
    
    return @[ rowOne, rowTwo, rowThree, rowFour, rowFive, rowSix ];
}

- (NSArray*) createSectionTwo
{
    RowContent* row = [RowContent new];
    
    row.title   = @"Сроки";
    row.detail  = [self createTermsLabelTextForStartDate: self.task.startDate
                                          withFinishDate: self.task.finishDate
                                            withDuration: self.task.duration];
    
    row.cellId  = self.addTaskTableViewCellsInfo[RightDetailCell];
    row.segueId = self.addTaskTableViewSeguesInfo[ShowTermsSegueID];
    
    return @[ row ];
}

- (NSArray*) createSectionThree
{
    RowContent* rowOne = [RowContent new];
    
    rowOne.title  = @"Помещение";
    rowOne.detail = @"Не реализовано";
    rowOne.cellId = self.addTaskTableViewCellsInfo[RightDetailCell];
    
    RowContent* rowTwo = [RowContent new];
    
    rowTwo.title  = @"Задача на плане";
    rowTwo.detail = @"Не реализовано";
    rowTwo.cellId = self.addTaskTableViewCellsInfo[RightDetailCell];
    
    RowContent* rowThree = [RowContent new];
    
    rowThree.title   = @"Этап";
    rowThree.detail  = @"Не реализовано";
    rowThree.cellId  = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowThree.segueId = self.addTaskTableViewSeguesInfo[ShowSelectStageSegueID];
    
    RowContent* rowFour = [RowContent new];
    
    rowFour.title   = @"Система";
    rowFour.detail  = @"Не реализовано";
    rowFour.cellId  = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowFour.segueId = self.addTaskTableViewSeguesInfo[ShowSelectSystemSegueID];
    
    RowContent* rowFive = [RowContent new];
    
    rowFive.title         = @"Тип задачи";
    rowFive.detail        = @"Не реализовано";
    rowFive.markImageName = @"GreenMark";
    rowFive.cellId        = self.addTaskTableViewCellsInfo[MarkedRightDetailCell];
    
    RowContent* rowSix = [RowContent new];
    
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
                     inSection: 0
                         inRow: 1];
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
        
        labelText = [NSString stringWithFormat: @"%@ - %@, %ld", firstDate, secondDate, duration];
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
    
//    UserInfo* currentUser = [[DataManager sharedInstance] getCurrentUserInfo];
    
//    NSArray* array = @[ currentUser ];
    
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

@end
