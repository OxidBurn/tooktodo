//
//  ProjectsEnumerations.h
//  TookTODO
//
//  Created by Nikolay Chaban on 8/24/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#ifndef ProjectsEnumerations_h
#define ProjectsEnumerations_h

typedef NS_ENUM(NSUInteger, AllProjectsSortingType)
{
    SortingByLastVisitingType,
    SortingByNameType,
    SortingByAdressType,
    SortingByCreationDateType,
};

typedef NS_ENUM(NSUInteger, ContentAccedingSortingType)
{
    GrowsSortingType      = 1,
    DiminutionSortingType = 0,
};

typedef NS_ENUM(NSUInteger, AllTasksCellType)
{
    AllTasksStageCellType,
    AllTasksTaskCellType,
};

typedef NS_ENUM(NSUInteger, TaskStatusType)
{
    TaskWaitingStatusType      = 0,
    TaskInProgressStatusType   = 1,
    TaskCompletedStatusType    = 2,
    TaskCanceledStatusType     = 3,
    TaskOnApprovingStatusType  = 4,
    TaskOnCompletionStatusType = 5,
};

typedef NS_ENUM(NSUInteger, ControllerTypeSelection) {
    
    SelectResponsibleController,
    SelectClaimingController,
    SelectObserversController
    
};

typedef NS_ENUM( NSUInteger, AddTaskTableViewCellType) {
    
    FlexibleTextFieldCell,
    FlexibleCell,
    RightDetailCell,
    SwitchCell,
    SingleUserInfoCell,
    GroupOfUsersCell,
    MarkedRightDetailCell,
};

typedef NS_ENUM(NSUInteger, AllSeguesList) {
    
    ShowAddMessageSegue,
    ShowResponsibleSegue,
    ShowClaimingSegue,
    ShowObserversSegue,
    
};

typedef NS_ENUM(NSUInteger, SelectResponsibleSelectAllFlag) {
    SelectAll,
    DeselectAll,
};


#endif /* ProjectsEnumerations_h */
