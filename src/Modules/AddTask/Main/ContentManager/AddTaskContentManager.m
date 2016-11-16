//
//  AddTaskContentManager.m
//  TookTODO
//
//  Created by Nikolay Chaban on 14.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskContentManager.h"

// Categories
#import "AddTaskContentManager+Helpers.h"
#import "AddTaskContentManager+UpdadingContent.h"

// Helpers
#import "ProjectsEnumerations.h"

@interface AddTaskContentManager()

// properties
@property (assign, nonatomic) AddTaskControllerType controllerType;

// methods


@end

@implementation AddTaskContentManager


#pragma mark - Properties -

- (NSArray*) addTaskContentArray
{
    if ( _addTaskContentArray == nil )
    {
        _addTaskContentArray = [self createTableViewContent];
    }
    
    return _addTaskContentArray;
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

- (NSArray*) addTaskTableViewCellsInfo
{
    if ( _addTaskTableViewCellsInfo == nil )
    {
        _addTaskTableViewCellsInfo = @[@"FlexibleTextFieldCellID",
                                       @"FlexibleTextCellID",
                                       @"RightDetailCellID",
                                       @"SwitchCellID",
                                       @"SingleUserInfoCellID",
                                       @"GroupOfUsersCellID",
                                       @"MarkedRightDetailsCellID"];
    }
    
    return _addTaskTableViewCellsInfo;
}


- (NSArray*) addTaskTableViewSeguesInfo
{
    if ( _addTaskTableViewSeguesInfo == nil )
    {
        _addTaskTableViewSeguesInfo = @[@"ShowAddMassageController",
                                        @"ShowAddTermTaskController",
                                        @"ShowSelectResponsibleController",
                                        @"ShowSelectClaimingController",
                                        @"ShowSelectObserversController",
                                        @"ShowSelectionPremisesController",
                                        @"ShowStages",
                                        @"ShowSystems",
                                        @"ShowRooms",
                                        @"ShowSelectingTaskInfoScreenID"];
    }
    
    return _addTaskTableViewSeguesInfo;
}


#pragma mark - Public -


- (NewTask*) getNewTaskObject
{
    return self.task;
}

- (NSArray*) getTableViewContentForControllerType: (AddTaskControllerType) controllerType
{
    self.controllerType = controllerType;
    
    return self.addTaskContentArray;
}

- (void) updateTaskNameWithString: (NSString*) newTaskName
{
    self.task.taskName = newTaskName;
    
    if ( [newTaskName isEqualToString: @""] )
    {
        newTaskName = @"Название задачи ";
    }
    
    RowContent* newRow = self.addTaskContentArray[SectionOne][TaskNameRow];
    
    newRow.title  = newTaskName;
    
    [self updateContentWithRow: newRow
                     inSection: SectionOne
                         inRow: TaskNameRow];
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
    RowContent* rowOne = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowOne.cellId    = self.addTaskTableViewCellsInfo[FlexibleTextFieldCell];
    rowOne.cellIndex = FlexibleTextFieldCell;
    rowOne.title     = self.task.taskName ? self.task.taskName : @"Название задачи";
    
    RowContent* rowTwo = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowTwo.cellId    = self.addTaskTableViewCellsInfo[FlexibleCell];
    rowTwo.cellIndex = FlexibleCell;
    rowTwo.title     = self.task.taskDescription ? self.task.taskDescription : @"Описание задачи";
    rowTwo.segueId = self.addTaskTableViewSeguesInfo[ShowAddCommentSegueId];
    
    RowContent* rowThree = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowThree.cellId    = self.addTaskTableViewCellsInfo[SwitchCell];
    rowThree.cellIndex = SwitchCell;
    rowThree.title     = @"Скрытая задача";
    rowThree.isHidden  = self.task.isHiddenTask? self.task.isHiddenTask : NO;
    rowThree.isSwitchEnabled = [self handleInteractionsForControllerType];
    
    RowContent* rowFour = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowFour.cellId       = self.addTaskTableViewCellsInfo[SingleUserInfoCell];
    rowFour.cellIndex    = SingleUserInfoCell;
    rowFour.title        = @"Ответственный";
    rowFour.membersArray = self.task.responsible? self.task.responsible : self.task.defaultResponsible;
    rowFour.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectResponsibleControllerSegueID];
    
    
    RowContent* rowFive = [[RowContent alloc] initWithUserInteractionEnabled];
    
    NSString* cellForRowFiveId = [self determineCellIdForGroupOfMembers: self.task.claiming];
    
    NSString* cellFiveDetailText  = [cellForRowFiveId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"Не выбраны" : @"";
    
    AddTaskTableViewCellType cellIndexRowFive = [self.addTaskTableViewCellsInfo indexOfObject: cellForRowFiveId];
    
    rowFive.cellId       = cellForRowFiveId;
    rowFive.cellIndex    = cellIndexRowFive;
    rowFive.title        = @"Утверждающие";
    rowFive.detail       = cellFiveDetailText;
    rowFive.membersArray = self.task.claiming;
    rowFive.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectClaimingControllerSegueID];
    
    RowContent* rowSix = [[RowContent alloc] initWithUserInteractionEnabled];
    
    NSString* cellForRowSixId = [self determineCellIdForGroupOfMembers: self.task.observers];
    
    NSString* cellSixDetailText  = [cellForRowSixId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"Не выбраны" : @"";
    
    AddTaskTableViewCellType cellIndexRowSix = [self.addTaskTableViewCellsInfo indexOfObject: cellForRowSixId];
    
    rowSix.cellId       = cellForRowSixId;
    rowSix.cellIndex    = cellIndexRowSix;
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
    
    row.cellId    = self.addTaskTableViewCellsInfo[RightDetailCell];
    row.cellIndex = RightDetailCell;
    row.segueId   = self.addTaskTableViewSeguesInfo[ShowTermsSegueID];
    
    return @[ row ];
}

- (NSArray*) createSectionThree
{
    RowContent* rowOne = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowOne.title     = @"Помещение";
    rowOne.detail    = @"Не выбрано";
    rowOne.cellId    = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowOne.cellIndex = RightDetailCell;
    rowOne.segueId   = self.addTaskTableViewSeguesInfo[ShowSelectRoomSegueID];
    
    RowContent* rowTwo = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowTwo.title     = @"Задача на плане";
    rowTwo.detail    = @"Не реализовано";
    rowTwo.cellId    = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowTwo.cellIndex = RightDetailCell;

    RowContent* rowThree = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowThree.title   = @"Этап";
    rowThree.detail  = @"Не реализовано";
    rowThree.cellId  = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowThree.segueId = self.addTaskTableViewSeguesInfo[ShowSelectStageSegueID];
    rowThree.cellIndex = RightDetailCell;
    
    RowContent* rowFour = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowFour.title   = @"Система";
    rowFour.detail  = @"Не реализовано";
    rowFour.cellId  = self.addTaskTableViewCellsInfo[RightDetailCell];
    // ToDo: uncomment when systems will be implemented
    rowFour.segueId = self.addTaskTableViewSeguesInfo[ShowSelectSystemSegueID];
    rowFour.cellIndex = RightDetailCell;
    
    RowContent* rowFive = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowFive.title     = @"Тип задачи";
    rowFive.detail    = @"Не выбран";
    rowFive.markImage = [UIColor colorWithRed:0.310 green:0.773 blue:0.176 alpha:1.000];
    rowFive.cellId    = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowFive.segueId   = self.addTaskTableViewSeguesInfo[ShowAddTaskTypeSegueID];
    rowFive.cellIndex = RightDetailCell;
    
    RowContent* rowSix = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowSix.title     = @"Документы к задаче";
    rowSix.detail    = @"Не реализовано";
    rowSix.cellId    = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowSix.cellIndex = RightDetailCell;

    return @[ rowOne, rowTwo, rowThree, rowFour, rowFive, rowSix ];
}

- (BOOL) handleInteractionsForControllerType
{
    BOOL isEnabled = YES;
    
    if ( self.controllerType == AddSubtaskControllerType )
    {
        isEnabled = NO;
    }
    
    return isEnabled;
}

@end
