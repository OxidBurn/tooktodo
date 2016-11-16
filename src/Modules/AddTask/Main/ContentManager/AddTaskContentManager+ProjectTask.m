//
//  AddTaskContentManager+ProjectTask.m
//  TookTODO
//
//  Created by Nikolay Chaban on 16.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskContentManager+ProjectTask.h"

#import "AddTaskContentManager+Helpers.h"
#import "TermsData.h"
#import "ProjectTaskWorkArea+CoreDataProperties.h"

@implementation AddTaskContentManager (ProjectTask)


#pragma mark - Public -

- (NSArray*) convertProjectTaskToContent: (ProjectTask*) task
{
    NSArray* sectionOne   = [self createSectionOneForTask: task];
    
    NSArray* sectionTwo   = [self createSectionTwoForTask: task];
    
    NSArray* sectionThree = [self createSectionThreeForTask: task];
    
    return [NSArray arrayWithObjects: sectionOne, sectionTwo, sectionThree, nil];
}


#pragma mark - Internal -

- (NSArray*) createSectionOneForTask: (ProjectTask*) task
{
    RowContent* rowOne = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowOne.cellId    = self.addTaskTableViewCellsInfo[FlexibleTextFieldCell];
    rowOne.cellIndex = FlexibleTextFieldCell;
    rowOne.title     = task.title;
    
    RowContent* rowTwo = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowTwo.cellId    = self.addTaskTableViewCellsInfo[FlexibleCell];
    rowTwo.cellIndex = FlexibleCell;
    rowTwo.title     = task.taskDescription ? task.taskDescription : @"Описание отсутствует";
    rowTwo.segueId   = self.addTaskTableViewSeguesInfo[ShowAddCommentSegueId];
    
    RowContent* rowThree = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowThree.cellId    = self.addTaskTableViewCellsInfo[SwitchCell];
    rowThree.cellIndex = SwitchCell;
    rowThree.title     = @"Скрытая задача";
    rowThree.isHidden  = task.access;
    
    RowContent* rowFour = [[RowContent alloc] initWithUserInteractionEnabled];
    
    NSUInteger rowFourIndex = task.responsible? RightDetailCell : SingleUserInfoCell;
    NSString* rowFourDetail = task.responsible? @"" : @"Не выбран";
    
    rowFour.cellId       = self.addTaskTableViewCellsInfo[SingleUserInfoCell];
    rowFour.detail       = rowFourDetail;
    rowFour.cellIndex    = rowFourIndex;
    rowFour.title        = @"Ответственный";
    //rowFour.membersArray = task.responsible? @[ task.responsible ] : @[ task.ownerUser ];
    rowFour.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectResponsibleControllerSegueID];
    
    
    RowContent* rowFive = [[RowContent alloc] initWithUserInteractionEnabled];
    
    NSString* cellForRowFiveId = [self determineCellIdForGroupOfMembers: self.task.claiming];
    
    NSString* cellFiveDetailText  = [cellForRowFiveId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"В разработке" : @"";
    
    AddTaskTableViewCellType cellIndexRowFive = [self.addTaskTableViewCellsInfo indexOfObject: cellForRowFiveId];
    
    rowFive.cellId       = cellForRowFiveId;
    rowFive.cellIndex    = cellIndexRowFive;
    rowFive.title        = @"Утверждающие";
    rowFive.detail       = cellFiveDetailText;
    // TODO: set claiming when it will be stored to data base
    //    rowFive.membersArray = self.task.claiming;
    rowFive.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectClaimingControllerSegueID];
    
    RowContent* rowSix = [[RowContent alloc] initWithUserInteractionEnabled];
    
    NSString* cellForRowSixId = [self determineCellIdForGroupOfMembers: self.task.observers];
    
    NSString* cellSixDetailText  = [cellForRowSixId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"В разработке" : @"";
    
    AddTaskTableViewCellType cellIndexRowSix = [self.addTaskTableViewCellsInfo indexOfObject: cellForRowSixId];
    
    rowSix.cellId       = cellForRowSixId;
    rowSix.cellIndex    = cellIndexRowSix;
    rowSix.title        = @"Наблюдатели";
    rowSix.detail       = cellSixDetailText;
    // TODO: set observers when it will be stored to data base
//    rowSix.membersArray = self.task.observers;
    rowSix.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectObserversControllerSegueID];
    
    return @[ rowOne, rowTwo, rowThree, rowFour, rowFive, rowSix ];
}

- (NSArray*) createSectionTwoForTask: (ProjectTask*) task
{
    RowContent* row = [[RowContent alloc] initWithUserInteractionEnabled];
    
    row.title   = @"Сроки";
    
    TermsData* terms = [TermsData new];
    
    terms.startDate         = task.startDay;
    terms.endDate           = task.endDate;
    terms.duration          = task.duration.integerValue;
    terms.includingWeekends = task.isIncludedRestDays;
    
    row.detail  = [self createTermsLabelTextForStartDate: terms.startDate
                                          withFinishDate: terms.endDate
                                            withDuration: terms.duration];
    
    row.cellId    = self.addTaskTableViewCellsInfo[RightDetailCell];
    row.cellIndex = RightDetailCell;
    row.segueId   = self.addTaskTableViewSeguesInfo[ShowTermsSegueID];
    
    return @[ row ];
}

- (NSArray*) createSectionThreeForTask: (ProjectTask*) task
{
    RowContent* rowOne = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowOne.title     = @"Помещение";
    rowOne.detail    = task.room.title;
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
    rowThree.detail  = task.stage.title;
    rowThree.cellId  = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowThree.segueId = self.addTaskTableViewSeguesInfo[ShowSelectStageSegueID];
    rowThree.cellIndex = RightDetailCell;
    
    RowContent* rowFour = [[RowContent alloc] initWithUserInteractionEnabled];
    
    NSString* rowFourDetail = task.workArea.title? task.workArea.title : @"Не выбрана";
    
    rowFour.title   = @"Система";
    rowFour.detail  = rowFourDetail;
    rowFour.cellId  = self.addTaskTableViewCellsInfo[RightDetailCell];
    // ToDo: uncomment when systems will be implemented
    rowFour.segueId = self.addTaskTableViewSeguesInfo[ShowSelectSystemSegueID];
    rowFour.cellIndex = RightDetailCell;
    
    RowContent* rowFive = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowFive.title     = @"Тип задачи";
    rowFive.detail    = task.taskTypeDescription;
    rowFive.markImage = [UIColor colorWithRed:0.310 green:0.773 blue:0.176 alpha:1.000];
    rowFive.cellId    = self.addTaskTableViewCellsInfo[MarkedRightDetailCell];
    rowFive.segueId   = self.addTaskTableViewSeguesInfo[ShowAddTaskTypeSegueID];
    rowFive.cellIndex = MarkedRightDetailCell;
    
    RowContent* rowSix = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowSix.title     = @"Документы к задаче";
    rowSix.detail    = @"Не реализовано";
    rowSix.cellId    = self.addTaskTableViewCellsInfo[RightDetailCell];
    rowSix.cellIndex = RightDetailCell;
    
    return @[ rowOne, rowTwo, rowThree, rowFour, rowFive, rowSix ];
}

@end
