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
#import "ProjectTaskResponsible+CoreDataClass.h"
#import "ProjectTaskRoleAssignments+CoreDataClass.h"
#import "ProjectTaskRoleAssignment+CoreDataClass.h"
#import "ProjectRoleAssignments+CoreDataClass.h"
#import "FilledTeamInfoPack.h"

@implementation AddTaskContentManager (ProjectTask)


#pragma mark - Public -

- (NSArray*) convertProjectTaskToContent: (ProjectTask*) task
{
    NSArray* sectionOne   = [self createSectionOneForTask: task];
    
    NSArray* sectionTwo   = [self createSectionTwoForTask: task];
    
    NSArray* sectionThree = [self createSectionThreeForTask: task];
    
    return [NSArray arrayWithObjects: sectionOne, sectionTwo, sectionThree, nil];
}

- (NewTask*) parseProjectTaskToNewTask: (ProjectTask*) task
{
    NewTask* newTask = [NewTask new];
    
    newTask.taskName               = task.title;
    newTask.taskDescription        = task.taskDescription;
    newTask.isHiddenTask           = task.access.boolValue;
    newTask.terms.startDate        = task.startDay;
    newTask.terms.endDate          = task.endDate;
    newTask.terms.factualStartDate = task.factualStartDate;
    newTask.terms.factualEndDate   = task.factualStartDate;
    newTask.terms.closedDate       = task.closedDate;
    newTask.level                  = task.roomLevel;
    newTask.room                   = task.room;
    newTask.taskType               = task.taskType.integerValue;
    newTask.stage                  = task.stage;
    
    // parsing responsible, claiming and observers
    [self fillMemebersforTask: task];
    
    newTask.responsible = self.task.responsible;
    newTask.claiming    = self.task.claiming;
    newTask.observers   = self.task.observers;
    
    return newTask;
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
    rowTwo.title     = task.descriptionValue.length > 0 ? task.descriptionValue : @"Описание отсутствует";
    rowTwo.segueId   = self.addTaskTableViewSeguesInfo[ShowAddCommentSegueId];
    
    RowContent* rowThree = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowThree.cellId    = self.addTaskTableViewCellsInfo[SwitchCell];
    rowThree.cellIndex = SwitchCell;
    rowThree.title     = @"Скрытая задача";
    rowThree.isHidden  = task.access;
    rowThree.isSwitchEnabled = YES;
    
    RowContent* rowFour = [[RowContent alloc] initWithUserInteractionEnabled];
    RowContent* rowFive = [[RowContent alloc] initWithUserInteractionEnabled];
    RowContent* rowSix  = [[RowContent alloc] initWithUserInteractionEnabled];
    
    [self fillMemebersforTask: task];
    
    NSString* responsibleCellId = [self determineCellIdForGroupOfMembers: self.task.responsible];
    NSString* claimingCellId    = [self determineCellIdForGroupOfMembers: self.task.claiming];
    NSString* observersCellId   = [self determineCellIdForGroupOfMembers: self.task.observers];
    
    NSString* responsibleDetailText  = [responsibleCellId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"Не указан" : @"";
    
    NSString* claimingDetailText  = [claimingCellId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"Не указаны" : @"";
    
    NSString* observersDetailText  = [observersCellId isEqualToString: self.addTaskTableViewCellsInfo[RightDetailCell]] ? @"Не указаны" : @"";

    AddTaskTableViewCellType rowFourIndex = [self.addTaskTableViewCellsInfo indexOfObject: responsibleCellId];
    
    rowFour.cellId       = responsibleCellId;
    rowFour.detail       = responsibleDetailText;
    rowFour.cellIndex    = rowFourIndex;
    rowFour.title        = @"Ответственный";
    rowFour.responsibleArray = self.task.responsible;
    rowFour.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectResponsibleControllerSegueID];
   
    if (rowFour.responsibleArray != nil && rowFour.responsibleArray.count > 0)
    {
        rowFour.membersArray = rowFour.responsibleArray;
    }
    

    AddTaskTableViewCellType cellIndexRowFive = [self.addTaskTableViewCellsInfo indexOfObject: claimingCellId];
    
    rowFive.cellId       = claimingCellId;
    rowFive.cellIndex    = cellIndexRowFive;
    rowFive.title        = @"Утверждающие";
    rowFive.claimingsArray = self.task.claiming;
    rowFive.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectClaimingControllerSegueID];
    rowFive.detail       = claimingDetailText;
    
    if (rowFive.claimingsArray != nil && rowFive.claimingsArray.count>0)
    {
        rowFive.membersArray = rowFive.claimingsArray;
    }
    
    AddTaskTableViewCellType cellIndexRowSix = [self.addTaskTableViewCellsInfo indexOfObject: observersCellId];
    

    rowSix.cellId       = observersCellId;
    rowSix.cellIndex    = cellIndexRowSix;
    rowSix.title        = @"Наблюдатели";
    rowSix.observersArray = self.task.observers;
    rowSix.segueId      = self.addTaskTableViewSeguesInfo[ShowSelectObserversControllerSegueID];
    rowSix.detail       = observersDetailText;
    
    if (rowSix.observersArray != nil && rowSix.observersArray.count > 0)
    {
        rowSix.membersArray = rowSix.observersArray;
    }
    
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
    
    if (task.rooms)
        rowOne.detail = task.rooms.firstObject.title;
    
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
    rowFour.segueId = self.addTaskTableViewSeguesInfo[ShowSelectSystemSegueID];
    rowFour.cellIndex = RightDetailCell;
    
    RowContent* rowFive = [[RowContent alloc] initWithUserInteractionEnabled];
    
    rowFive.title     = @"Тип задачи";
    rowFive.detail    = task.taskTypeDescription;
    rowFive.markImage = [self getColorForTaskType: task.taskType.integerValue];
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


- (void) fillMemebersforTask: (ProjectTask*) task;
{
    NSArray* roleAssignments = task.taskRoleAssignments.array;
    
    self.task.responsible = [NSArray array];
    self.task.claiming    = [NSArray array];
    self.task.observers   = [NSArray array];
    
    __block NSMutableArray* tmpResponsibleArr = self.task.responsible.mutableCopy;
    __block NSMutableArray* tmpClaimingsArr   = self.task.claiming.mutableCopy;
    __block NSMutableArray* tmpObserversArr   = self.task.observers.mutableCopy;
    
    [roleAssignments enumerateObjectsUsingBlock: ^(ProjectTaskRoleAssignments*  _Nonnull taskRoleAssignments, NSUInteger idx, BOOL * _Nonnull stop) {
        
        switch (taskRoleAssignments.taskRoleType.integerValue)
        {
            case ResponsibleRoleType:
            {
                NSArray* taskRoleAss = taskRoleAssignments.projectRoleAssignment.array;
                
                [taskRoleAss enumerateObjectsUsingBlock: ^(ProjectTaskRoleAssignment*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (obj.assignee || obj.invite)
                    {
                        NSArray* assigneeArr = obj.assignee.array;
                        NSArray* inviteArr   = obj.invite.array;
                        
                        [tmpResponsibleArr addObjectsFromArray: assigneeArr];
                        [tmpResponsibleArr addObjectsFromArray: inviteArr];
                        
                        [self convertMembersToFilledTeamInfoFromArray: tmpResponsibleArr];
                    }
                    
                }];
            }
                break;
                
            case ClaimingsRoleType:
            {
                NSArray* taskRoleAss = taskRoleAssignments.projectRoleAssignment.array;
                
                [taskRoleAss enumerateObjectsUsingBlock:^(ProjectTaskRoleAssignment*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (obj.assignee || obj.invite)
                    {
                        NSArray* assigneeArr = obj.assignee.array;
                        NSArray* inviteArr = obj.invite.array;
                        
                        [tmpClaimingsArr addObjectsFromArray: assigneeArr];
                        [tmpClaimingsArr addObjectsFromArray: inviteArr];
                        
                        [self convertMembersToFilledTeamInfoFromArray: tmpClaimingsArr];
                    }
                    
                }];
            }
                break;
                
            case ObserverRoleType:
            {
                NSArray* taskRoleAss = taskRoleAssignments.projectRoleAssignment.array;
                
                [taskRoleAss enumerateObjectsUsingBlock: ^(ProjectTaskRoleAssignment*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (obj.assignee || obj.invite)
                    {
                        NSArray* assigneeArr = obj.assignee.array;
                        NSArray* inviteArr   = obj.invite.array;
                        
                        [tmpObserversArr addObjectsFromArray: assigneeArr];
                        [tmpObserversArr addObjectsFromArray: inviteArr];
                        
                        [self convertMembersToFilledTeamInfoFromArray: tmpObserversArr];
                    }
                    
                }];
                
            }
                break;
                
            default:
                break;
                
        }
    }];
    
    self.task.responsible = tmpResponsibleArr.copy;
    self.task.claiming    = tmpClaimingsArr.copy;
    self.task.observers   = tmpObserversArr.copy;
    
    tmpObserversArr = nil;
    tmpClaimingsArr = nil;
    tmpResponsibleArr = nil;
}

- (void) convertMembersToFilledTeamInfoFromArray: (NSArray*) array
{
    __block  FilledTeamInfo* convertedUser = nil;
    __block NSMutableArray* arrWithConvertedUsers = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        convertedUser = [FilledTeamInfoPack convertObjectToTeamMember: obj];
        
        [arrWithConvertedUsers addObject: convertedUser];
        
    }];
    
    array = arrWithConvertedUsers;
    
    arrWithConvertedUsers = nil;
}

- (UIColor*) getColorForTaskType: (TaskType) taskType
{
    UIColor* typeColor = [UIColor clearColor];
    
    switch (taskType)
    {
        case TaskWorkType:
            typeColor = [UIColor colorWithRed:0.310 green:0.773 blue:0.176 alpha:1.000];
            break;
            
        case TaskAgreementType:
            typeColor = [UIColor colorWithRed:0.424 green:0.663 blue:0.792 alpha:1.000];
            break;
            
        case TaskObservationType:
            typeColor = [UIColor colorWithRed:1.00 green:0.89 blue:0.27 alpha:1.00];
            break;
            
        case TaskRemarkType:
            typeColor = [UIColor colorWithRed:0.961 green:0.651 blue:0.137 alpha:1.000];
            break;
    }
    
    return typeColor;
}

@end
