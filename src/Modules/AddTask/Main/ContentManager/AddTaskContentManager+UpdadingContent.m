//
//  AddTaskContentManager+UpdadingContent.m
//  TookTODO
//
//  Created by Nikolay Chaban on 14.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskContentManager+UpdadingContent.h"

// Classes
#import "OSSwitchTableCell.h"
#import "AddMessageViewController.h"
#import "SelectResponsibleViewController.h"
#import "AddTermTasksViewController.h"
#import "SelectSystemViewController.h"
#import "SelectStageViewController.h"
#import "SelectRoomViewController.h"
#import "AddTaskTypeViewController.h"

#import "TaskRowContent.h"

// Categories
#import "AddTaskContentManager+Helpers.h"

@interface AddTaskContentManager() 

// properties


// methods


@end

@implementation AddTaskContentManager (UpdadingContent)


#pragma mark - Public -

- (void) fillDefaultStage: (ProjectTaskStage*)     stage
           andHiddenState: (BOOL)                  isHidden
        forControllerType: (AddTaskControllerType) controllerType
{
    self.task.isHiddenTask = isHidden;
    self.task.stage        = stage;
    
    RowContent* rowHiddenTsk = self.addTaskContentArray[SectionOne][TaskHiddenStatusRow];
    
    rowHiddenTsk.isHidden = isHidden;
    
    [self updateContentWithRow: rowHiddenTsk
                     inSection: SectionOne
                         inRow: TaskHiddenStatusRow];
    
    RowContent* rowStage = self.addTaskContentArray[SectionThree][TaskStageRow];
    
    rowStage.detail = stage.title;
    
    [self disableUserInteractionForStageWithControllerType: controllerType];
    
    [self updateContentWithRow: rowStage
                     inSection: SectionThree
                         inRow: TaskStageRow];
    
}

- (NSArray*) updateTaskHiddenProperty: (BOOL) isHidden
{
    self.task.isHiddenTask = isHidden;
    
    RowContent* newRow = self.addTaskContentArray[SectionOne][TaskHiddenStatusRow];
    
    newRow.isHidden = isHidden;
    
    [self updateContentWithRow: newRow
                     inSection: SectionOne
                         inRow: TaskHiddenStatusRow];
    
    return self.addTaskContentArray;
}

- (NSArray*) updateSelectedResponsibleInfo: (NSArray*) selectedUsersArray
{
    self.task.responsible = selectedUsersArray;
    
    RowContent* row = self.addTaskContentArray[SectionOne][TaskResponsibleRow];
    
    row.membersArray     = selectedUsersArray;
    row.responsibleArray = selectedUsersArray;
    
    [self updateContentWithRow: row
                     inSection: SectionOne
                         inRow: TaskResponsibleRow];
    
    return self.addTaskContentArray;
}

- (NSArray*) updateSelectedClaimingInfo: (NSArray*) selectedClaiming
{
    self.task.claiming = selectedClaiming;
    
    RowContent* row = self.addTaskContentArray[SectionOne][TaskClaimingRow];
    
    if ( selectedClaiming )
    {
        row.cellId    = [self determineCellIdForGroupOfMembers: selectedClaiming];
        row.cellIndex = [self determintCellIndexForCellId: row.cellId];
    }
    
    row.membersArray = selectedClaiming;
    row.claimingsArray = selectedClaiming;
    
    row.cellId = [self determineCellIdForContent: selectedClaiming];
    row.cellIndex = [self determintCellIndexForCellId: row.cellId];
    
    if ( selectedClaiming.count == 0 )
        row.detail = @"Не выбраны";
    
    [self updateContentWithRow: row inSection: SectionOne inRow: TaskClaimingRow];
    
    return self.addTaskContentArray;
}

- (NSArray*) updateSelectedObserversInfo: (NSArray*) selectedObservers
{
    self.task.observers = selectedObservers;
    
    RowContent* row = self.addTaskContentArray[SectionOne][TaskObserversRow];
    
    row.membersArray = selectedObservers;
    row.observersArray = selectedObservers;
    
    if ( selectedObservers )
    {
        row.cellId    = [self determineCellIdForGroupOfMembers: selectedObservers];
        row.cellIndex = [self determintCellIndexForCellId: row.cellId];
    }
    
    [self updateContentWithRow: row inSection: SectionOne inRow: TaskObserversRow];
    
    return self.addTaskContentArray;
}


- (void) updateSelectedSystem: (ProjectSystem*) system
{
    self.task.system = system;
    
    RowContent* row = self.addTaskContentArray[SectionThree][TaskSystemRow];
    
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
}

- (void) updateSelectedStage: (ProjectTaskStage*) stage
{
    self.task.stage = stage;
    
    RowContent* row = self.addTaskContentArray[SectionThree][TaskStageRow];
    
    if (stage)
    {
        row.cellId    = self.addTaskTableViewCellsInfo[RightDetailCell];
        row.cellIndex = RightDetailCell;
        row.detail    = stage.title;
    }
    else
    {
        row.detail = @"Не выбрано";
    }
    
    
    [self updateContentWithRow: row
                     inSection: SectionThree
                         inRow: TaskStageRow];
}

- (void) updateSelectedInfo: (id) info
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
    
    RowContent* row = self.addTaskContentArray[SectionThree][TaskPremisesRow];
    
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
}

- (void) updateSelectedTaskType: (TaskType)  type
                withDescription: (NSString*) typeDescription
                      withColor: (UIColor*)  typeColor
{
    self.task.taskType = type;
    self.task.typeDescription = typeDescription;
    
    RowContent* row = self.addTaskContentArray[SectionThree][TaskTypeRow];
    
    row.cellId    = self.addTaskTableViewCellsInfo[MarkedRightDetailCell];
    row.cellIndex = MarkedRightDetailCell;
    row.markImage = typeColor;
    row.detail    = typeDescription;
    
    [self updateContentWithRow: row
                     inSection: SectionThree
                         inRow: TaskTypeRow];
}

- (void) updateTerms: (TermsData*) terms
{
    self.task.terms.startDate  = terms.startDate;
    self.task.terms.endDate    = terms.endDate;
    self.task.terms.duration   = terms.duration;
    
    
    
    RowContent* row = self.addTaskContentArray[SectionTwo][TaskTermsRow];
    
    row.detail = [self createTermsLabelTextForStartDate: terms.startDate
                                         withFinishDate: terms.endDate
                                           withDuration: terms.duration];
}

- (void) updateTaskDescription: (NSString*) taskDescription
{
    self.task.taskDescription = taskDescription;
    
    RowContent* newRow = self.addTaskContentArray[0][1];
    
    newRow.title = taskDescription;
    
    if ( [taskDescription isEqualToString: @"Описание задачи"] )
    {
        taskDescription = @"";
    }
    
    [self updateContentWithRow: newRow
                     inSection: SectionOne
                         inRow: TaskDescriptionRow];
}

#pragma mark - Internal -

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

- (void) disableUserInteractionForStageWithControllerType: (AddTaskControllerType) controllerType
{
    RowContent* rowStage = self.addTaskContentArray[SectionThree][TaskStageRow];
    
    switch (controllerType)
    {
        case AddNewTaskControllerType:
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

@end
