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
                    statuses = status.stringValue;
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
            TaskFilterRowContent* filterByMemberRow = [TaskFilterRowContent new];
            
            NSString* filterByMemberRowCellId = [self determineCellIdForContent: filterConfig.byResponsible];
            
            filterByMemberRow.title            = self.allTitlesArray[SectionOne][FilterByMemberRow];
            filterByMemberRow.cellTypeId       = [self determineCellTypeIdForCellId: filterByMemberRowCellId];
            filterByMemberRow.cellId           = filterByMemberRowCellId;
            filterByMemberRow.detail           = @"Не выбрано";
            filterByMemberRow.detailIsSelected = NO;
            
            TaskFilterRowContent* filterByRoleRow = [TaskFilterRowContent new];
            
            NSString* filterByRoleRowCellId = [self determineCellIdForContent: filterConfig.byResponsible];
            
            filterByRoleRow.title            = self.allTitlesArray[SectionOne][FilterByRoleRow];
            filterByRoleRow.cellTypeId       = [self determineCellTypeIdForCellId: filterByRoleRowCellId];
            filterByRoleRow.cellId           = filterByRoleRowCellId;
            filterByRoleRow.detail           = @"Не выбрано";
            filterByRoleRow.detailIsSelected = NO;
            
            sectionOneContent = @[ filterByMemberRow,
                                   filterByRoleRow ];
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
    filterByTermsRow.cellTypeId       = TaskFilterCustomDisclosureCell;
    filterByTermsRow.cellId           = self.cellsIdArray[TaskFilterCustomDisclosureCell];
    filterByTermsRow.detail           = @"Не выбрано";
    filterByTermsRow.detailIsSelected = NO;
    filterByTermsRow.rowHeight        = 50.f;
    filterByTermsRow.termsType        = FilterByTermsType;
    
    TaskFilterRowContent* filterByFactTermsRow = [TaskFilterRowContent new];
    
    filterByFactTermsRow.title            = self.allTitlesArray[SectionTwo][FilterByFactTermsRow];
    filterByFactTermsRow.cellTypeId       = TaskFilterCustomDisclosureCell;
    filterByFactTermsRow.cellId           = self.cellsIdArray[TaskFilterCustomDisclosureCell];
    filterByFactTermsRow.detail           = @"Не выбрано";
    filterByFactTermsRow.detailIsSelected = NO;
    filterByFactTermsRow.rowHeight        = 50.f;
    filterByFactTermsRow.termsType        = FilterByFactTermsType;
    
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
            
            filterByWorkRoomRow.title            = self.allTitlesArray[SectionThree][FilterByWorkRoomRow];
            filterByWorkRoomRow.cellTypeId       = TaskFilterRightDetailCell;
            filterByWorkRoomRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            filterByWorkRoomRow.detail           = @"Не выбрано";
            filterByWorkRoomRow.detailIsSelected = NO;
            
            TaskFilterRowContent* filterBySystemRow = [TaskFilterRowContent new];
            
            filterBySystemRow.title            = self.allTitlesArray[SectionThree][FilterBySystemRow];
            filterBySystemRow.cellTypeId       = TaskFilterRightDetailCell;
            filterBySystemRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            filterBySystemRow.detail           = @"Не выбрана";
            filterBySystemRow.detailIsSelected = NO;
            
            TaskFilterRowContent* filterByTaskTypeRow = [TaskFilterRowContent new];
            
            filterByTaskTypeRow.title            = self.allTitlesArray[SectionThree][FilterByTaskTypeRow];
            filterByTaskTypeRow.cellTypeId       = TaskFilterRightDetailCell;
            filterByTaskTypeRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            filterByTaskTypeRow.detail           = @"Не выбран";
            filterByTaskTypeRow.detailIsSelected = NO;
            
            sectionThree = @[ filterByWorkRoomRow,
                              filterBySystemRow,
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
            
            TaskFilterRowContent* filterBySystemRow = [TaskFilterRowContent new];
            
            filterBySystemRow.title            = self.allTitlesArray[SectionThree][FilterBySystemRow];
            filterBySystemRow.cellTypeId       = TaskFilterRightDetailCell;
            filterBySystemRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            filterBySystemRow.detail           = @"Не выбрано";
            filterBySystemRow.detailIsSelected = NO;
            
            TaskFilterRowContent* filterByTaskTypeRow = [TaskFilterRowContent new];
            
            filterByTaskTypeRow.title            = self.allTitlesArray[SectionThree][FilterByTaskTypeRow];
            filterByTaskTypeRow.cellTypeId       = TaskFilterRightDetailCell;
            filterByTaskTypeRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
            filterByTaskTypeRow.detail           = @"Не выбрано";
            filterByTaskTypeRow.detailIsSelected = NO;
            
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
                               
@end
