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

typedef NS_ENUM(NSUInteger, TasksSortingType)
{
    SortByName,
    SortByStartDay,
    SortByEndDay,
    SortByFactStartDay,
    SortByFactEndDay,
    SortByResponsible,
    SortByRoom,
    SortBySystem,
    SortByStatus,
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
    TaskCancelRequestType      = 6,
};

typedef NS_ENUM(NSUInteger, ControllerTypeSelection) {
    
    SelectResponsibleController,
    SelectClaimingController,
    SelectObserversController
    
};

typedef NS_ENUM(NSUInteger, TaskType)
{
    TaskWorkType        = 0,
    TaskAgreementType   = 1,
    TaskObservationType = 2,
    TaskRemarkType      = 3,
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
    ShowTermsSegue,
    ShowStagesSegue,
    ShowSystemSegue,
    ShowRoomsSegue,
    ShowTaskTypeSegue,

};

typedef NS_ENUM(NSUInteger, SelectResponsibleSelectAllFlag) {
    SelectAll,
    DeselectAll,
};

typedef NS_ENUM(NSUInteger, AllSwitchCellsTags) {
   
    AddTaskIsHiddenTaskSwitchTag,
    AddTermsIncludingWeekendsSwitchTag,
    AddTermsIsUrgentTaskSwitchTag,
    
};

typedef NS_ENUM(NSUInteger, TaskInfoSecondSectionContentType) {
    
    SubtasksContentType,
    AttachmentsContentType,
    CommentsContentType,
    LogsContentType,
    
};


typedef NS_ENUM(NSUInteger, TaskDetailTableViewCells) {
    
    TaskDetailCellType,
    TaskDescriptionCellType,
    CollectionCellType,
    SubtaskInfoCellType,
    AttachmentsCellType,
    CommentsCellType,
    LogWithActionCellType,
    LogWithDetailCellType,
    LogCellType,
    FilterSubtasksCellType,
    FilterAttachmentsCellType,
    AddCommentCellType,
    
};


typedef NS_ENUM(NSUInteger, SectionsList) {
    
    SectionOne,
    SectionTwo,
    SectionThree,
    
};

#endif /* ProjectsEnumerations_h */
