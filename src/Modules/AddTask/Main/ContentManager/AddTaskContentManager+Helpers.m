//
//  AddTaskContentManager+Helpers.m
//  TookTODO
//
//  Created by Nikolay Chaban on 14.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskContentManager+Helpers.h"

// Classes
#import "NSDate+Helper.h"
#import "Utils.h"
#import "DataManager+UserInfo.h"

@implementation AddTaskContentManager (Helpers)


#pragma mark - Public -

- (void) updateContentWithRow: (RowContent*) newRow
                    inSection: (NSUInteger)  section
                        inRow: (NSUInteger)  row
{
    NSArray* sectionContent = self.addTaskContentArray[section];
    
    NSMutableArray* contentCopy = [NSMutableArray arrayWithArray: self.addTaskContentArray];
    
    NSMutableArray* sectionCopy = [NSMutableArray arrayWithArray: sectionContent];
    
    [sectionCopy replaceObjectAtIndex: row withObject: newRow];
    
    sectionContent = [sectionCopy copy];
    
    [contentCopy replaceObjectAtIndex: section withObject: sectionContent];
    
    self.addTaskContentArray = [contentCopy copy];
}

- (NSString*) createTermsLabelTextForStartDate: (NSDate*) startDate
                                withFinishDate: (NSDate*) finishDate
                                  withDuration: (NSUInteger) duration
{
    NSString* labelText;
    
    if ( startDate && finishDate )
    {
        NSString* firstDate  = [NSDate stringFromDate: startDate withFormat: @"dd.MM"];
        
        NSString* secondDate = [NSDate stringFromDate: finishDate withFormat: @"dd.MM.yyyy"];
        
        labelText = [NSString stringWithFormat: @"%@ - %@, %@", firstDate, secondDate, [Utils generateStringOfDaysCount: duration]];
    } else
    {
        labelText = @"Не выбраны";
    }
    
    return labelText;
}

- (NSString*) determineCellIdForGroupOfMembers: (NSArray*) membersGroup
{
    NSString* cellID = [NSString new];
    
    if ( membersGroup.count == 0 || membersGroup == nil )
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

- (NSArray*) getCurrentUserInfoArray
{
    UserInfo* userInfo = [DataManagerShared getCurrentUserInfo];
    
    FilledTeamInfo* teamInfo = [FilledTeamInfo new];
    
    [teamInfo convertUserToTeamInfo: userInfo];
    
    return teamInfo ? [@[teamInfo] copy] : nil;
}

// Helpers for case when we create new subtask besed on main task

- (BOOL) handleEnabledSwitchStateForContent: (RowContent*)           rowContent
                          forControllerType: (AddTaskControllerType) controllerType
{
    
    switch (controllerType)
    {
        case AddNewTaskControllerType:
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

- (void) disableUserInteractionForStageInController: (AddTaskControllerType) controllerType
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

- (AddTaskTableViewCellType) determintCellIndexForCellId: (NSString*) cellId
{
    NSUInteger index = [self.addTaskTableViewCellsInfo indexOfObject: cellId];
    
    return index;
}





@end
