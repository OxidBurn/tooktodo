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

// Task statuses and available actions

typedef NS_ENUM(NSUInteger, TaskStatusType)
{
    TaskToPauseStatusType      = 0,
    TaskToInWorkStatusType     = 1,
    TaskCompleteStatusType     = 2,
    TaskCancelStatusType       = 3,
    TaskToOnApprovalStatusType = 4,
    TaskOnReworkStatusType     = 5,
    TaskToCancelStatusType     = 6,
    TaskToReworkStatusType     = 7,
    TaskRenewStatusType        = 8,
    TaskApproveStatusType      = 9,
};



typedef NS_ENUM(NSUInteger, AssignmentRoleType)
{
    ResponsibleRoleType,
    ClaimingsRoleType,
    ObserverRoleType,
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

typedef NS_ENUM(NSUInteger, TaskInfoSecondSectionContentType)
{    
    SubtasksContentType,
    AttachmentsContentType,
    CommentsContentType,
    LogsContentType,
    
};


typedef NS_ENUM(NSUInteger, TaskDetailTableViewCells)
{
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
    LogDefaultCellType,
    LogWithUpdatedStringValuesType,
    LogWithChangedStatusCellType,
    LogWithAssigneeCellType,
    LogWithTaskTypeCellType,
    LogWithRenamedCellType,
    LogWithMarkCellType,
    LogWithErrorCellType,
    LogWithAttachmentCellType,
    LogWithCommentCellType,
};


typedef NS_ENUM(NSUInteger, SectionsList)
{
    SectionOne,
    SectionTwo,
    SectionThree,
    SectionFour,
};

typedef NS_ENUM(NSUInteger, AddTaskControllerType)
{
    AddNewTaskControllerType, // Create new task screen
    AddSubtaskControllerType, // Create new subtask screen
    EditTaskControllerType, // Editing task screen
};

// Enumerations for tasks filter

typedef NS_ENUM(NSUInteger, TaskFilterCellId)
{
    TaskFilterSingleUserCell,
    TaskFilterRightDetailCell,
    TaskFilterSwitchCell,
    TaskFilterCustomDisclosureCell,
    TaskFilterFilterByTermsCell,
    TaskFilterGroupOfUsersCell,
};


typedef NS_ENUM(NSUInteger, FilterByTermsCellType)
{
    FilterByTermsType,
    FilterByFactTermsType,
};


typedef NS_ENUM(NSUInteger, FilterByDateViewControllerType)
{
    ByTermsBeginning,
    ByTermsEnding,
    ByFactTermsBeginning,
    ByFactTermsEnding,
};



typedef NS_ENUM(NSUInteger, FilterByDatesCellId)
{
    FilterByDatesRightDetailCell,
    FilterByDatesDatePickerCell,
    
};

typedef NS_ENUM(NSUInteger, FilterByDatesPickerTag)
{
    StartDate = 1,
    EndDate   = 2,
};

typedef NS_ENUM(NSUInteger, TasksFilterType)
{
    FilterBySingleProject,
    FilterByAllProjects,
};

typedef NS_ENUM(NSUInteger, FilterByAssigneeType)
{
    FilterByCreator,
    FilterByResponsible,
    FilterByApprovers,
    FilterByAllMembers,
};


typedef NS_ENUM(NSUInteger, TaskFilterAditionalOptionsTags)
{
    FilterByDoneTasksTag     = 11,
    FilterByCanceledTasksTag = 12,
    FilterByOverdueTasksTag  = 13,
};

typedef NS_ENUM(NSUInteger, TaskFilterByMyRoleInProject)
{
    Participant,
    Responsible,
    Claiming,
    Creator,
};

typedef NS_ENUM(NSInteger, PermissionTypeList) {
    
    SystemAdminPermission = -1,
    ParticipantPermission = 0,
    OwnerPermission       = 1,
    AdminPermission       = 2,
};


typedef NS_ENUM(NSUInteger, FilterTagParameterType)
{
    CreatorsFilterParameter,
    CreatorsAllFilterParameter,
    ResponsiblesFilterParamter,
    ResponsiblesAllFilterParamter,
    ApprovesFilterParameter,
    ApprovesAllFilterParameter,
    StatusesFilterParameter,
    StatusesAllFilterParameter,
    StartDateFilterParameter,
    EndDateFilterParameter,
    FactualStartDateFilterParameter,
    FactualEndDateFilterParameter,
    RoomsFilterParameter,
    RoomsAllFilterParameter,
    WorkAreasFilterParameter,
    WorkAreasAllFilterParameter,
    TypeFilterParameter,
    TypeAllFilterParameter,
    DoneFilterParameter,
    ExpiredFilterParameter,
    CanceledFilterParameter,
    ProjectRoleFilterParameter,
    ProjectsFilterParameter,
    ProjectsAllFilterParameter,
};

// enums for working with task logs

typedef NS_ENUM(NSUInteger, LogsActionType)
{
    AddedNewValueType,
    EditedOldValueType,
    DeletedValueType,
};

typedef NS_ENUM(NSUInteger, TaskLogsType)
{
    LogCreatedTaskType = 0, // создал задачу (без инфы про задачу)
    LogAddedAttachmentType = 1, // прикрепил документ "документ"
    LogDeletedAttachmentType = 2, // удалил документ "документ"
    LogAddedUserWithRoleType = 3, // добавил "роль" ( приходяд данные об одном пользователе )
    LogDeletedUserWithRoleType = 4, // aналогично п.3 только удаление
    LogChangedTaskNameType = 5, // сменил название задачи с "название1" на "название2"
    LogAddedMarkType = 6, // добавил метку "метка"
    LogDeletedMarkType = 7, // удалил метку "метка"
    
    LogAddedDatesType = 8, // добавил сроки "дата1" - "дата2"
    LogChangedDatesType = 9, // изменил сроки (без данных о сроках)
    LogDeletedDatesType = 10, // удалил сроки (без данных о сроках)
    LogChangedDatesToNewValueType = 11, // изменил сроки с "срок1" на "срок2"
    LogDeletedRoomType = 12, // удалил комнату (без инфе о комнате)
    LogAddedRoomType = 13, // добалил комнату с инфой о комнате
    LogChangedRoomType = 14, // изменил помещение с "пом1" на "пом2"
    
    LogMovedTaskType = 15, // перенес задачу с "этап1" в "этап2"
    LogTookTaskToWorkType = 16, //взял задачу в работу (в вебе без описания, у нас, вероятно, с иконкой "В работу")
    LogChangedTypeOfTaskType = 17, // изменил тип задачи с "тип1" на "тип2"
    LogChangedTaskStatusType = 18, // будет хендлить все логи, связанные со статусами задач (принимает 2 статуса)
    //LogSentTaskToOnApprovalType = 18, // отправил задачу на утверждение ( возможно будут прихотить типы задач "В работе" и "На утверждение"
   // LogSentTaskToWaitingType = 19, // отправил задачу в ожидание ( возможно приходит 2 типа задачи )
    LogAddedCommentType = 20, // добавил комментрарий ( приходит commentId )
    //LogCanceledTaskType = 21, // отменил задачу ( возможно приходит 2 типа задачи )
};


#endif /* ProjectsEnumerations_h */
