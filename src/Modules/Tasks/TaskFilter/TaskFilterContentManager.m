//
//  TaskFilterContentManager.m
//  TookTODO
//
//  Created by Nikolay Chaban on 01.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskFilterContentManager.h"

// Classes
#import "TaskFilterRowContent.h"
#import "TaskStatusDefaultValues.h"
#import "NSDate+Helper.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "ProjectSystem+CoreDataProperties.h"

typedef NS_ENUM(NSUInteger, SectionOneRow)
{
    FilterByOwnerRow,
    FilterByResponsibleRow,
    FilterByClaimingRow,
    FilterByTaskStatusRow,
    FilterByMemberRow,
    FilterByRoleRow,
};

typedef NS_ENUM(NSUInteger, SectionTwoRow)
{
    FilterByTermsRow,
    FilterByFactTermsRow,
};

typedef NS_ENUM(NSUInteger, SectionThreeRow)
{
    FilterByWorkRoomRow,
    FilterBySystemRow,
    FilterByTaskTypeRow,
    FilterByProjectRow,
    FilterByStatusRow,
};

typedef NS_ENUM(NSUInteger, SectionFourRow)
{
    FilterByDoneTasksRow,
    FilterByCanceledTasksRow,
    FilterByOverdueTasksRow,
};

@interface TaskFilterContentManager()

// properties
@property (strong, nonatomic) NSArray* allTitlesArray;

@property (strong, nonatomic) NSArray* cellsIdArray;

@property (strong, nonatomic) NSArray* seguesIdArray;

@property (assign, nonatomic) BOOL isTermsRowExpanded;

@property (assign, nonatomic) BOOL isFactTermsRowExpanded;

// methods


@end

@implementation TaskFilterContentManager


#pragma mark - Properties -

- (NSArray*) allTitlesArray
{
    if ( _allTitlesArray == nil )
    {
        _allTitlesArray = @[@[ @"По создателю",
                               @"По ответственному",
                               @"По утверждающему",
                               @"По статусу",
                               @"По участнику",
                               @"По роли в проекте"],
                            @[ @"По срокам",
                               @"По фактическим датам",],
                            @[ @"По помещению",
                               @"По системе",
                               @"По типу",
                               @"По проекту",
                               @"По статусу" ],
                            @[ @"Выполнены",
                               @"Отменены",
                               @"Только просроченные"]];
    }
    
    return _allTitlesArray;
}

- (NSArray*) cellsIdArray
{
    if ( _cellsIdArray == nil )
    {
        _cellsIdArray = @[ @"SingleUserInfoCellID",
                           @"RightDetailCellID",
                           @"SwitchCellID",
                           @"CustomDisclosureIconCellID",
                           @"FilterByTermsCellID",
                           @"GroupOfUsersCellID" ];
    }
    
    return _cellsIdArray;
}

- (NSArray*) seguesIdArray
{
    if ( _seguesIdArray == nil )
    {
        _seguesIdArray = [NSArray new];
    }
    
    return _seguesIdArray;
}


#pragma mark - Public -

- (NSArray*) getTableViewContentForConfiguration: (TaskFilterConfiguration*) filterConfig
                                  withFilterType: (TasksFilterType)          filterType
{
    NSArray* sectionOne   = [self createSectionOneForConfig:   filterConfig
                                              forFilterType:   filterType];
    
    NSArray* sectionTwo   = [self createSectionTwoForConfig:   filterConfig];
    
    NSArray* sectionThree = [self createSectionThreeForConfig: filterConfig
                                                forFilterType: filterType];

    NSArray* sectionFour  = [self createSectionFourForConfig:  filterConfig];
    
    NSArray* content = @[ sectionOne, sectionTwo, sectionThree, sectionFour ];
    
    return content;
}

- (void) updateExpandedStateWithIndexPath: (NSIndexPath*) indexPath
{
    switch ( indexPath.row )
    {
        case 0:
            
            self.isTermsRowExpanded = !self.isTermsRowExpanded;
            
            break;
            
        case 1:
        {
            self.isFactTermsRowExpanded = !self.isFactTermsRowExpanded;
        }
            break;
            
        default:
            break;
    }
}

#pragma mark - Internal -

- (NSArray*) createSectionOneForConfig: (TaskFilterConfiguration*) filterConfig
                         forFilterType: (TasksFilterType)          filterType
{
    NSArray* sectionOneContent = [[NSArray alloc] init];
    
    switch ( filterType )
    {
        case FilterBySingleProject:
        {
            TaskFilterRowContent* filterByOwnerRow = [TaskFilterRowContent new];
            
            NSString* filterByOwnerRowCellId = [self determineCellIdForContent: filterConfig.byCreator];
            
            filterByOwnerRow.title            = self.allTitlesArray[SectionOne][FilterByOwnerRow];
            filterByOwnerRow.cellTypeId       = [self determineCellTypeIdForCellId: filterByOwnerRowCellId];
            filterByOwnerRow.cellId           = filterByOwnerRowCellId;
            filterByOwnerRow.detail           = @"Не выбрано";
            filterByOwnerRow.detailIsSelected = (filterByOwnerRow.cellTypeId == TaskFilterRightDetailCell) ? NO: YES;
            filterByOwnerRow.selectedUsers    = filterConfig.byCreator;
            
            TaskFilterRowContent* filterByResponsibleRow = [TaskFilterRowContent new];
            
            NSString* filterByResponsibleRowCellId = [self determineCellIdForContent: filterConfig.byResponsible];
            
            filterByResponsibleRow.title            = self.allTitlesArray[SectionOne][FilterByResponsibleRow];
            filterByResponsibleRow.cellTypeId       = [self determineCellTypeIdForCellId: filterByResponsibleRowCellId];
            filterByResponsibleRow.cellId           = filterByResponsibleRowCellId;
            filterByResponsibleRow.detail           = @"Не выбрано";
            filterByResponsibleRow.detailIsSelected = (filterByResponsibleRow.cellTypeId == TaskFilterRightDetailCell) ? NO: YES;
            filterByResponsibleRow.selectedUsers    = filterConfig.byResponsible;
            
            TaskFilterRowContent* filterByApproversRow = [TaskFilterRowContent new];
            
            NSString* filterByApproversRowCellId = [self determineCellIdForContent: filterConfig.byApprovers];
            
            filterByApproversRow.title            = self.allTitlesArray[SectionOne][FilterByClaimingRow];
            filterByApproversRow.cellTypeId       = [self determineCellTypeIdForCellId: filterByApproversRowCellId];
            filterByApproversRow.cellId           = filterByApproversRowCellId;
            filterByApproversRow.detail           = @"Не выбрано";
            filterByApproversRow.detailIsSelected = (filterByApproversRow.cellTypeId == TaskFilterRightDetailCell) ? NO: YES;
            filterByApproversRow.selectedUsers    = filterConfig.byApprovers;
            
            TaskFilterRowContent* filterByTaskStatusRow = [TaskFilterRowContent new];
            
            filterByTaskStatusRow.title            = self.allTitlesArray[SectionOne][FilterByTaskStatusRow];
            filterByTaskStatusRow.cellTypeId       = TaskFilterRightDetailCell;
            filterByTaskStatusRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            
            if ( filterConfig.statusesList.count > 0)
            {
                NSNumber* status = filterConfig.statusesList.firstObject;
                filterByTaskStatusRow.detailIsSelected = YES;

                __block NSString* statuses = [[TaskStatusDefaultValues sharedInstance] returnTitleForTaskStatus: status.integerValue];
                
                if ( filterConfig.statusesList.count == 1)
                {
                    NSNumber* status = filterConfig.statusesList.firstObject;
                    statuses = [[TaskStatusDefaultValues sharedInstance] returnTitleForTaskStatus: status.integerValue];
                }
                else
                {
                    [filterConfig.statusesList enumerateObjectsUsingBlock: ^(NSNumber* status, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ( idx > 0)
                        {
                            statuses = [statuses stringByAppendingString: [NSString stringWithFormat: @" ,%@",[[TaskStatusDefaultValues sharedInstance] returnTitleForTaskStatus: status.integerValue]]];
                        }
                        
                    }];
                }
                
                filterByTaskStatusRow.detail           = statuses;
            }
            else
            {
            filterByTaskStatusRow.detail           = @"Не выбрано";
            filterByTaskStatusRow.detailIsSelected = NO;
            }
            
            sectionOneContent = @[ filterByOwnerRow,
                                   filterByResponsibleRow,
                                   filterByApproversRow,
                                   filterByTaskStatusRow ];

        }
            break;
        
        case FilterByAllProjects:
        {
//            TaskFilterRowContent* filterByMemberRow = [TaskFilterRowContent new];
//            
//            NSString* filterByMemberRowCellId = [self determineCellIdForContent: filterConfig.byResponsible];
//            
//            filterByMemberRow.title            = self.allTitlesArray[SectionOne][FilterByMemberRow];
//            filterByMemberRow.cellTypeId       = [self determineCellTypeIdForCellId: filterByMemberRowCellId];
//            filterByMemberRow.cellId           = filterByMemberRowCellId;
//            filterByMemberRow.detail           = @"Не выбрано";
//            filterByMemberRow.detailIsSelected = NO;
            
            TaskFilterRowContent* filterByRoleRow = [TaskFilterRowContent new];
            
            NSString* filterByRoleRowCellId = self.cellsIdArray[TaskFilterRightDetailCell];
            
            filterByRoleRow.title            = self.allTitlesArray[SectionOne][FilterByRoleRow];
            filterByRoleRow.cellTypeId       = [self determineCellTypeIdForCellId: filterByRoleRowCellId];
            filterByRoleRow.cellId           = filterByRoleRowCellId;
            filterByRoleRow.detail           = [self getRoleDecriptionForType: filterConfig.byMyRoleInProject.integerValue];
            filterByRoleRow.detailIsSelected = YES;
            
            sectionOneContent = @[ filterByRoleRow ];
        }
            break;
            
        default:
            break;
    }
    
    return sectionOneContent;
}

- (NSArray*) createSectionTwoForConfig: (TaskFilterConfiguration*) filterConfig
{
    TaskFilterRowContent* filterByTermsRow = [TaskFilterRowContent new];
    
    filterByTermsRow.title            = self.allTitlesArray[SectionTwo][FilterByTermsRow];
    
    BOOL isExpanded = self.isTermsRowExpanded;
    
    filterByTermsRow.isExpanded = isExpanded;
    
    NSString* newCellId = isExpanded ? @"FilterByTermsCellID" : @"CustomDisclosureIconCellID";
    
    CGFloat newRowHeight = isExpanded ? 110 : 50;
    
    NSUInteger cellIdType = isExpanded? TaskFilterFilterByTermsCell : TaskFilterCustomDisclosureCell;
    
    filterByTermsRow.rowHeight  = newRowHeight;
    filterByTermsRow.cellId     = newCellId;
    filterByTermsRow.cellTypeId = cellIdType;
    
    filterByTermsRow.detail           = [self getDetailForStartTerms: filterConfig.byTermsStart
                                                         andEndTerms: filterConfig.byTermsEnd];
    
    filterByTermsRow.detailIsSelected = [filterByTermsRow.detail isEqualToString: @"Не выбрано"] ? NO : YES;
    
    filterByTermsRow.termsType        = FilterByTermsType;

    NSString* startTermsString = [self getTermsLabelForTerms: filterConfig.byTermsStart];
    
    NSString* endTermsString   = [self getTermsLabelForTerms: filterConfig.byTermsEnd];
    
    filterByTermsRow.startTermsString = startTermsString;
    filterByTermsRow.endTermsString   = endTermsString;
    
    filterByTermsRow.isStartTermSelected = [startTermsString isEqualToString: @"Не выбрано"] ? NO : YES;
    
    filterByTermsRow.isEndTermsSelected = [endTermsString isEqualToString: @"Не выбрано"] ? NO : YES;
    
    // Second Row
    TaskFilterRowContent* filterByFactTermsRow = [TaskFilterRowContent new];
    
    filterByFactTermsRow.title            = self.allTitlesArray[SectionTwo][FilterByFactTermsRow];
    
    BOOL isExpandedFactTerms = self.isFactTermsRowExpanded;
    
    filterByFactTermsRow.isExpanded = isExpandedFactTerms;
    
    NSString* cellId = isExpandedFactTerms ? @"FilterByTermsCellID" : @"CustomDisclosureIconCellID";
    
    CGFloat rowHeight = isExpandedFactTerms ? 110 : 50;
    
    NSUInteger cellIdTypeFactTerms = isExpandedFactTerms? TaskFilterFilterByTermsCell : TaskFilterCustomDisclosureCell;
    
    filterByFactTermsRow.rowHeight  = rowHeight;
    filterByFactTermsRow.cellId     = cellId;
    filterByFactTermsRow.cellTypeId = cellIdTypeFactTerms;
    
    filterByFactTermsRow.detail           = [self getDetailForStartTerms: filterConfig.byTermsStart
                                                         andEndTerms: filterConfig.byTermsEnd];
    filterByFactTermsRow.detailIsSelected = NO;
    filterByFactTermsRow.termsType        = FilterByTermsType;
    
    filterByFactTermsRow.detailIsSelected = [filterByFactTermsRow.detail isEqualToString: @"Не выбрано"] ? NO : YES;
    filterByFactTermsRow.termsType        = FilterByFactTermsType;
    
    NSString* startFactTermsString = [self getTermsLabelForTerms: filterConfig.byFactTermsStart];
    
    NSString* endFactTermsString   = [self getTermsLabelForTerms: filterConfig.byFactTermsEnd];
    
    filterByFactTermsRow.startTermsString = startFactTermsString;
    filterByFactTermsRow.endTermsString   = endFactTermsString;
    
    filterByFactTermsRow.isStartTermSelected = [startFactTermsString isEqualToString: @"Не выбрано"] ? NO : YES;
    
    filterByFactTermsRow.isEndTermsSelected = [endFactTermsString isEqualToString: @"Не выбрано"] ? NO : YES;
    
    NSArray* sectionTwoContent = @[ filterByTermsRow, filterByFactTermsRow ];
    
    return sectionTwoContent;
}

- (NSArray*) createSectionThreeForConfig: (TaskFilterConfiguration*) filterConfig
                           forFilterType: (TasksFilterType)          filterType
{
    NSArray* sectionThree = [NSArray new];
    
    switch ( filterType )
    {
        case FilterByAllProjects:
        {
            
            TaskFilterRowContent* filterByWorkRoomRow = [TaskFilterRowContent new];
            
            filterByWorkRoomRow.title            = self.allTitlesArray[SectionThree][FilterByProjectRow];
            filterByWorkRoomRow.cellTypeId       = TaskFilterRightDetailCell;
            filterByWorkRoomRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            filterByWorkRoomRow.detail           = @"Не выбрано";
            filterByWorkRoomRow.detailIsSelected = NO;
            
            
            TaskFilterRowContent* filterByStatusRow = [TaskFilterRowContent new];
            
            filterByStatusRow.title            = self.allTitlesArray[SectionThree][FilterByStatusRow];
            filterByStatusRow.cellTypeId       = TaskFilterRightDetailCell;
            filterByStatusRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            
            if ( filterConfig.statusesList.count > 0)
            {
                NSNumber* status = filterConfig.statusesList.firstObject;
                filterByStatusRow.detailIsSelected = YES;
                
                __block NSString* statuses = [[TaskStatusDefaultValues sharedInstance] returnTitleForTaskStatus: status.integerValue];
                
                if ( filterConfig.statusesList.count == 1)
                {
                    NSNumber* status = filterConfig.statusesList.firstObject;
                    statuses = [[TaskStatusDefaultValues sharedInstance] returnTitleForTaskStatus: status.integerValue];
                }
                else
                {
                    [filterConfig.statusesList enumerateObjectsUsingBlock: ^(NSNumber* status, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ( idx > 0)
                        {
                            statuses = [statuses stringByAppendingString: [NSString stringWithFormat: @" ,%@",[[TaskStatusDefaultValues sharedInstance] returnTitleForTaskStatus: status.integerValue]]];
                        }
                        
                    }];
                }
                
                filterByStatusRow.detail           = statuses;
            }
            else
            {
                filterByStatusRow.detail           = @"Не выбрано";
                filterByStatusRow.detailIsSelected = NO;
            }
            
            TaskFilterRowContent* filterByTaskTypeRow = [TaskFilterRowContent new];
            
            filterByTaskTypeRow.title            = self.allTitlesArray[SectionThree][FilterByTaskTypeRow];
            filterByTaskTypeRow.cellTypeId       = TaskFilterRightDetailCell;
            filterByTaskTypeRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            
            if ( filterConfig.byTaskType.count > 0)
            {
                
                NSNumber* taskType = filterConfig.byTaskType.firstObject;
                filterByTaskTypeRow.detailIsSelected = YES;
            
                __block NSString* types = [self getTaskTypeDescriptionForIndex: taskType.integerValue];
                
                if (filterConfig.byTaskType.count >=2)
                {
                    [filterConfig.byTaskType enumerateObjectsUsingBlock: ^(NSNumber* type, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ( idx > 0)
                        {
                            types = [types stringByAppendingString: [NSString stringWithFormat: @" ,%@", [self getTaskTypeDescriptionForIndex: type.integerValue]]];
                        }
                        
                    }];
                }
                
                filterByTaskTypeRow.detail = types;
            }
            else
            {
                filterByTaskTypeRow.detail           = @"Не выбрано";
                filterByTaskTypeRow.detailIsSelected = NO;
            }

            
            sectionThree = @[ filterByWorkRoomRow,
                              filterByStatusRow,
                              filterByTaskTypeRow ];
        }
            
            break;
            
        case FilterBySingleProject:
        {
            TaskFilterRowContent* filterByWorkRoomRow = [TaskFilterRowContent new];
            
            filterByWorkRoomRow.title            = self.allTitlesArray[SectionThree][FilterByWorkRoomRow];
            filterByWorkRoomRow.cellTypeId       = TaskFilterRightDetailCell;
            filterByWorkRoomRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            filterByWorkRoomRow.detail           = @"Не выбрано";
            filterByWorkRoomRow.detailIsSelected = NO;
            
            
            if ( filterConfig.byRooms.count > 0)
            {
                filterByWorkRoomRow.detailIsSelected = YES;
                
                if (filterConfig.byRooms.count > 1)
                {
                    __block NSMutableString* tmpRoomsTitles = [NSMutableString string];
                    
                    [filterConfig.byRooms enumerateObjectsUsingBlock: ^(ProjectTaskRoom* room, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        NSString* roomTitle = [NSString stringWithFormat: @"%@, ", [self getRoomTitleForFilterConfig: filterConfig
                                                                                                            forIndex: idx]];
                        
                        [tmpRoomsTitles appendString: roomTitle];
                        
                    }];
                    
                    filterByWorkRoomRow.detail = tmpRoomsTitles.copy;
                    
                    tmpRoomsTitles = nil;
                }
                else
                {
                    filterByWorkRoomRow.detail = [self getRoomTitleForFilterConfig: filterConfig
                                                                          forIndex: 0];
                }
            }
            else
            {
                filterByWorkRoomRow.detail           = @"Не выбрано";
                filterByWorkRoomRow.detailIsSelected = NO;
            }

            TaskFilterRowContent* filterBySystemRow = [TaskFilterRowContent new];
            
            filterBySystemRow.title            = self.allTitlesArray[SectionThree][FilterBySystemRow];
            filterBySystemRow.cellTypeId       = TaskFilterRightDetailCell;
            filterBySystemRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            filterBySystemRow.detail           = @"Не выбрано";
            filterBySystemRow.detailIsSelected = NO;
            
            
            if ( filterConfig.bySystem.count > 0)
            {
                filterBySystemRow.detailIsSelected = YES;
                
                if (filterConfig.bySystem.count > 1)
                {
                    __block NSMutableString* tmpSystemTitles = [NSMutableString string];
                    
                    [filterConfig.byRooms enumerateObjectsUsingBlock: ^(ProjectSystem* system, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        NSString* systemTytle = [NSString stringWithFormat: @"%@, ", [self getSystemTitleForFilterConfig: filterConfig
                                                                                                                forIndex: idx]];
                        
                        [tmpSystemTitles appendString: systemTytle];
                        
                    }];
                    
                    filterBySystemRow.detail = tmpSystemTitles.copy;
                    
                    tmpSystemTitles = nil;
                }
                else
                {
                    filterBySystemRow.detail = [self getSystemTitleForFilterConfig: filterConfig
                                                                          forIndex: 0];
                }
            }
            else
            {
                filterByWorkRoomRow.detail           = @"Не выбрано";
                filterByWorkRoomRow.detailIsSelected = NO;
            }

            
            
            
            TaskFilterRowContent* filterByTaskTypeRow = [TaskFilterRowContent new];
            
            filterByTaskTypeRow.title            = self.allTitlesArray[SectionThree][FilterByTaskTypeRow];
            filterByTaskTypeRow.cellTypeId       = TaskFilterRightDetailCell;
            filterByTaskTypeRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            
            if ( filterConfig.byTaskType.count > 0)
            {
                
                NSNumber* taskType = filterConfig.byTaskType.firstObject;
                filterByTaskTypeRow.detailIsSelected = YES;
                
                __block NSString* types = [self getTaskTypeDescriptionForIndex: taskType.integerValue];
                
                if (filterConfig.byTaskType.count >=2)
                {
                    [filterConfig.byTaskType enumerateObjectsUsingBlock: ^(NSNumber* type, NSUInteger idx, BOOL * _Nonnull stop) {
                        
                        if ( idx > 0)
                        {
                            types = [types stringByAppendingString: [NSString stringWithFormat: @" ,%@", [self getTaskTypeDescriptionForIndex: type.integerValue]]];
                        }
                        
                    }];
                }
                
                filterByTaskTypeRow.detail = types;
            }
            else
            {
                filterByTaskTypeRow.detail           = @"Не выбрано";
                filterByTaskTypeRow.detailIsSelected = NO;
            }

            
            sectionThree = @[ filterByWorkRoomRow,
                              filterBySystemRow,
                              filterByTaskTypeRow ];
        }
            break;
            
        default:
            break;
    }
    
    
    return sectionThree;
}

- (NSArray*) createSectionFourForConfig: (TaskFilterConfiguration*) filterConfig
{
    TaskFilterRowContent* filterByDoneTasksRow = [TaskFilterRowContent new];
    
    filterByDoneTasksRow.title         = self.allTitlesArray[SectionFour][FilterByDoneTasksRow];
    filterByDoneTasksRow.cellTypeId    = TaskFilterSwitchCell;
    filterByDoneTasksRow.cellId        = self.cellsIdArray[TaskFilterSwitchCell];
    
    filterByDoneTasksRow.switchControllTag = FilterByDoneTasksTag;
    
    TaskFilterRowContent* filterByCanceledTasksRow = [TaskFilterRowContent new];
    
    filterByCanceledTasksRow.title            = self.allTitlesArray[SectionFour][FilterByCanceledTasksRow];
    filterByCanceledTasksRow.cellTypeId       = TaskFilterSwitchCell;
    filterByCanceledTasksRow.cellId           = self.cellsIdArray[TaskFilterSwitchCell];
    
    filterByCanceledTasksRow.switchControllTag = FilterByCanceledTasksTag;

    TaskFilterRowContent* filterByOverdueTasksRow = [TaskFilterRowContent new];
    
    filterByOverdueTasksRow.title            = self.allTitlesArray[SectionFour][FilterByOverdueTasksRow];
    filterByOverdueTasksRow.cellTypeId       = TaskFilterSwitchCell;
    filterByOverdueTasksRow.cellId           = self.cellsIdArray[TaskFilterSwitchCell];
    
    filterByOverdueTasksRow.switchControllTag = FilterByOverdueTasksTag;

    NSArray* sectionFour = @[ filterByDoneTasksRow,
                              filterByCanceledTasksRow,
                              filterByOverdueTasksRow ];
    
    return sectionFour;
}


#pragma mark - Helpers -

- (NSString*) determineCellIdForContent: (NSArray*) arrayToCheck
{
    NSString* cellId;
    
    if ( arrayToCheck == nil || arrayToCheck.count == 0 )
    {
        cellId = self.cellsIdArray[TaskFilterRightDetailCell];
    } else
        if ( arrayToCheck.count == 1 )
        {
            cellId = self.cellsIdArray[TaskFilterSingleUserCell];
        } else
            cellId = self.cellsIdArray[TaskFilterGroupOfUsersCell];
    
    return cellId;
}

- (TaskFilterCellId) determineCellTypeIdForCellId: (NSString*) cellId
{
    NSUInteger index = [self.cellsIdArray indexOfObject: cellId];
    
    return index;
}


- (NSString*) getTaskTypeDescriptionForIndex: (NSUInteger) index
{
    NSString* description = [NSString new];
    
    switch ( index )
    {
        case TaskWorkType:        description = @"Работа"; break;
        case TaskAgreementType:   description = @"Согласование"; break;
        case TaskRemarkType:      description = @"Замечание"; break;
        case TaskObservationType: description = @"Наблюдение"; break;
            
        default:
            break;
    }
    
    return description;
}

- (NSString*) getRoleDecriptionForType: (TaskFilterByMyRoleInProject) roleType
{
    NSString* description = [NSString new];
    
    switch ( roleType )
    {
        case Participant: description = @"Я участник"; break;
        case Responsible: description = @"Я ответственный"; break;
        case Claiming:    description = @"Я утверждающий"; break;
        case Creator:     description = @"Я создатель"; break;
            
        default:
            break;
    }
    
    return description;
}

#pragma mark - Helpers for task terms -

- (NSString*) getDetailForStartTerms: (TermsData*) startTerms
                         andEndTerms: (TermsData*) endTerms
{
    NSString* detail = [NSString new];
    
    if ( (startTerms.startDateString) ||
         (startTerms.endDateString)   ||
         (endTerms.startDateString)   ||
         (endTerms.endDateString) )
    {
        detail = @"Выбраны";
    }
    else
    {
        detail = @"Не выбраны";
    }
    
    return detail;
}

- (NSString*) getTermsLabelForTerms: (TermsData*) terms
{
    NSString* startDateString = terms.startDateString;
    NSString* endDateString   = terms.endDateString;
    
    NSString* detailString = [NSString string];
    
    if ( startDateString )
    {
        if ( endDateString )
        {
            detailString = [NSString stringWithFormat: @"%@ - %@",
                            terms.startDateString,
                            terms.endDateString];
        }
        else
            detailString = startDateString;
    }
    else
    {
        if ( endDateString)
        {
            detailString = endDateString;
        }
        else
            detailString = @"Не выбрано";
    }

    return detailString;
}

- (NSString*) getRoomTitleForFilterConfig: (TaskFilterConfiguration*) filterConfig
                                 forIndex: (NSUInteger)               index
{
   ProjectTaskRoom* room  = filterConfig.byRooms[index];

    return room.title;
}

- (NSString*) getSystemTitleForFilterConfig: (TaskFilterConfiguration*) filterConfig
                                   forIndex: (NSUInteger)               index
{
    ProjectSystem* system  = filterConfig.bySystem[index];
    
    return system.title;
}

@end
