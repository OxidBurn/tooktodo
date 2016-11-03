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

typedef NS_ENUM(NSUInteger, SectionOneRow)
{
    FilterByOwnerRow,
    FilterByResponsibleRow,
    FilterByClaimingRow,
    FilterByTaskStatusRow,
};

typedef NS_ENUM(NSUInteger, SectionTwoRow)
{
    FilterByTermsRow,
    FilterByFactTermsRow,
};

typedef NS_ENUM(NSUInteger, SectionThreeRow)
{
    FilterByWorkAreaRow,
    FilterBySystemRow,
    FilterByTaskTypeRow,
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
                               @"По статусу"],
                            @[ @"По срокам",
                               @"По фактическим датам",],
                            @[ @"По помещению",
                               @"По системе",
                               @"По типу"],
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
{
    NSArray* sectionOne   = [self createSectionOneForConfig:   filterConfig];
    
    NSArray* sectionTwo   = [self createSectionTwoForConfig:   filterConfig];
    
    NSArray* sectionThree = [self createSectionThreeForConfig: filterConfig];

    NSArray* sectionFour  = [self createSectionFourForConfig:  filterConfig];
    
    NSArray* content = @[ sectionOne, sectionTwo, sectionThree, sectionFour ];
    
    return content;
}


#pragma mark - Internal -

- (NSArray*) createSectionOneForConfig: (TaskFilterConfiguration*) filterConfig
{
    TaskFilterRowContent* filterByOwnerRow = [TaskFilterRowContent new];
    
    NSString* filterByOwnerRowCellId = [self determineCellIdForContent: filterConfig.byOwner];
    
    filterByOwnerRow.title            = self.allTitlesArray[SectionOne][FilterByOwnerRow];
    filterByOwnerRow.cellTypeId       = [self determineCellTypeIdForCellId: filterByOwnerRowCellId];
    filterByOwnerRow.cellId           = filterByOwnerRowCellId;
    filterByOwnerRow.detail           = @"Не выбрано";
    filterByOwnerRow.detailIsSelected = NO;
    
    TaskFilterRowContent* filterByResponsibleRow = [TaskFilterRowContent new];
    
    NSString* filterByResponsibleRowCellId = [self determineCellIdForContent: filterConfig.byResponsible];

    filterByResponsibleRow.title            = self.allTitlesArray[SectionOne][FilterByResponsibleRow];
    filterByResponsibleRow.cellTypeId       = [self determineCellTypeIdForCellId: filterByResponsibleRowCellId];
    filterByResponsibleRow.cellId           = filterByResponsibleRowCellId;
    filterByResponsibleRow.detail           = @"Не выбрано";
    filterByResponsibleRow.detailIsSelected = NO;
    
    TaskFilterRowContent* filterByClaimingRow = [TaskFilterRowContent new];
    
    NSString* filterByClaimingRowCellId = [self determineCellIdForContent: filterConfig.byClaiming];

    filterByClaimingRow.title            = self.allTitlesArray[SectionOne][FilterByClaimingRow];
    filterByClaimingRow.cellTypeId       = [self determineCellTypeIdForCellId: filterByClaimingRowCellId];
    filterByClaimingRow.cellId           = filterByClaimingRowCellId;
    filterByClaimingRow.detail           = @"Не выбрано";
    filterByClaimingRow.detailIsSelected = NO;
    
    TaskFilterRowContent* filterByTaskStatusRow = [TaskFilterRowContent new];
    
    filterByTaskStatusRow.title            = self.allTitlesArray[SectionOne][FilterByTaskStatusRow];
    filterByTaskStatusRow.cellTypeId       = TaskFilterRightDetailCell;
    filterByTaskStatusRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
    filterByTaskStatusRow.detail           = @"Не выбрано";
    filterByTaskStatusRow.detailIsSelected = NO;
    
    NSArray* sectionOneContent = @[ filterByOwnerRow,
                                    filterByResponsibleRow,
                                    filterByClaimingRow,
                                    filterByTaskStatusRow];
    
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
    
    TaskFilterRowContent* filterByFactTermsRow = [TaskFilterRowContent new];
    
    filterByFactTermsRow.title            = self.allTitlesArray[SectionTwo][FilterByFactTermsRow];
    filterByFactTermsRow.cellTypeId       = TaskFilterCustomDisclosureCell;
    filterByFactTermsRow.cellId           = self.cellsIdArray[TaskFilterCustomDisclosureCell];
    filterByFactTermsRow.detail           = @"Не выбрано";
    filterByFactTermsRow.detailIsSelected = NO;
    filterByFactTermsRow.rowHeight        = 50.f;
    
    NSArray* sectionTwoContent = @[ filterByTermsRow, filterByFactTermsRow ];
    
    return sectionTwoContent;
}

- (NSArray*) createSectionThreeForConfig: (TaskFilterConfiguration*) filterConfig
{
    TaskFilterRowContent* filterByWorkAreaRow = [TaskFilterRowContent new];
    
    filterByWorkAreaRow.title            = self.allTitlesArray[SectionThree][FilterByWorkAreaRow];
    filterByWorkAreaRow.cellTypeId       = TaskFilterRightDetailCell;
    filterByWorkAreaRow.cellId           = self.cellsIdArray[TaskFilterRightDetailCell];
    filterByWorkAreaRow.detail           = @"Не выбрано";
    filterByWorkAreaRow.detailIsSelected = NO;
    
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
    
    NSArray* sectionThree = @[ filterByWorkAreaRow,
                               filterBySystemRow,
                               filterByTaskTypeRow ];
    
    return sectionThree;
}

- (NSArray*) createSectionFourForConfig: (TaskFilterConfiguration*) filterConfig
{
    TaskFilterRowContent* filterByDoneTasksRow = [TaskFilterRowContent new];
    
    filterByDoneTasksRow.title            = self.allTitlesArray[SectionFour][FilterByDoneTasksRow];
    filterByDoneTasksRow.cellTypeId       = TaskFilterSwitchCell;
    filterByDoneTasksRow.cellId           = self.cellsIdArray[TaskFilterSwitchCell];
    filterByDoneTasksRow.detail           = @"Не выбрано";
    filterByDoneTasksRow.detailIsSelected = NO;
    
    TaskFilterRowContent* filterByCanceledTasksRow = [TaskFilterRowContent new];
    
    filterByCanceledTasksRow.title            = self.allTitlesArray[SectionFour][FilterByCanceledTasksRow];
    filterByCanceledTasksRow.cellTypeId       = TaskFilterSwitchCell;
    filterByCanceledTasksRow.cellId           = self.cellsIdArray[TaskFilterSwitchCell];
    filterByCanceledTasksRow.detail           = @"Не выбрано";
    filterByCanceledTasksRow.detailIsSelected = NO;
    
    TaskFilterRowContent* filterByOverdueTasksRow = [TaskFilterRowContent new];
    
    filterByOverdueTasksRow.title            = self.allTitlesArray[SectionFour][FilterByOverdueTasksRow];
    filterByOverdueTasksRow.cellTypeId       = TaskFilterSwitchCell;
    filterByOverdueTasksRow.cellId           = self.cellsIdArray[TaskFilterSwitchCell];
    filterByOverdueTasksRow.detail           = @"Не выбрано";
    filterByOverdueTasksRow.detailIsSelected = NO;
    
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
