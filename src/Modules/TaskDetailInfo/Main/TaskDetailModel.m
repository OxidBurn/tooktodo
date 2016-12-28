//
//  TaskModel.m
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailModel.h"

// Frameworks

// Classes
#import "DataManager+Tasks.h"
#import "TasksService.h"
#import "ChangeStatusViewController.h"
#import "TaskDetailContentManager.h"
#import "AddTaskContentManager+UpdadingContent.h"
#import "TaskAvailableActionsList+CoreDataClass.h"
#import "TaskAvailableStatusAction+CoreDataClass.h"

// Helpers
#import "ProjectsEnumerations.h"
#import "NSObject+Sorting.h"

@interface TaskDetailModel()

// properties
@property (strong, nonatomic) ProjectTask* task;

@property (strong, nonatomic) NSArray* taskTableViewContent;

@property (strong, nonatomic) TaskDetailContentManager* contentManager;

@property (assign, nonatomic) TaskInfoSecondSectionContentType secondSectionContentType;

@property (assign, nonatomic) CGRect tableViewFrame;

@property (nonatomic, strong) ProjectTask* selectedSubtask;

@property (nonatomic, assign) BOOL isSubtask;

@end

@implementation TaskDetailModel


#pragma mark - Properties -

- (TaskDetailContentManager*) contentManager
{
    if ( _contentManager == nil )
    {
        _contentManager = [TaskDetailContentManager new];
    }
    
    return _contentManager;
}

- (ProjectTask*) task
{
    if ( _task == nil )
    {
        _task = [DataManagerShared getSelectedTask];
    }
    
    return _task;
}


#pragma mark - Public -

- (BOOL) hasAvailableStatusesActions
{
    // getting all available status actions
    NSArray* availableStatusActions = self.task.availableActions.statusActions.allObjects;
    
    // creating array with IDs of available actions
    NSMutableArray* tmpDefaultArray = [NSMutableArray new];
    
    [availableStatusActions enumerateObjectsUsingBlock: ^(TaskAvailableStatusAction* action, NSUInteger idx, BOOL * _Nonnull stop) {

            [tmpDefaultArray addObject: action.statusActionID];        
    }];
    
    return (tmpDefaultArray.count > 0);
}

- (TaskStatusType) getTaskStatus
{
    return self.task.status.integerValue;
}

- (NSString*) getTaskTitle
{
    return self.task.title;
}

- (NSString*) getTaskDescriptionValue
{
    return self.task.descriptionValue;
}

- (TaskInfoSecondSectionContentType) getSecondSectionContentType
{
    return self.secondSectionContentType;
}

- (TaskRowContent*) getContentForIndexPath: (NSIndexPath*) indexPath
{
    return self.taskTableViewContent[indexPath.section][indexPath.row];
}

- (NSUInteger) returnNumberOfRowsForIndexPath: (NSInteger) section
{
    NSArray* sectionContent = self.taskTableViewContent[section];
    
    return sectionContent.count;
}

- (void) deselectTaskWithCompletion: (CompletionWithSuccess) completion
{
    if (self.isSubtask == YES)
    {
        [[TasksService sharedInstance] changeSelectedStageForTask: self.selectedSubtask
                                                withSelectedState: NO
                                                   withCompletion: ^(BOOL isSuccess) {
                                                       
                                                       // Select parent task
                                                       [[TasksService sharedInstance] changeSelectedStageForTask: self.selectedSubtask.task
                                                                                               withSelectedState: YES
                                                                                                  withCompletion: completion];
                                                   }];
        
        
    }
    
    else
    {
        [[TasksService sharedInstance] changeSelectedStageForTask: self.task
                                                withSelectedState: NO
                                                   withCompletion: completion];
    }
}

- (NSArray*) returnHeaderNumbersInfo
{
    NSArray* headerInfo = @[ @(self.task.subTasks.count),
                             self.task.attachments ? self.task.attachments : @0,
                             self.task.commentsCount ? @([self.task comments].count) : @(0),
                             @(self.task.logs.count) ];
    
    return headerInfo;
}

- (void) updateSecondSectionContentType: (NSUInteger) typeIndex
{
    self.secondSectionContentType = typeIndex;
    
    NSArray* newSectionTwo = [self.contentManager createSectionTwoContentAccordingToType: typeIndex
                                                                                 forTask: self.task];
    
    NSMutableArray* contentCopy = self.taskTableViewContent.mutableCopy;
    
    [contentCopy replaceObjectAtIndex: 1
                           withObject: newSectionTwo];
    
    self.taskTableViewContent = contentCopy.copy;
}

- (void) updateTaskStatusWithCompletion: (CompletionWithSuccess) completion
{
    @weakify(self)
    
    [[[TasksService sharedInstance] updateStatusForSelectedTask: self.task.status.integerValue] subscribeCompleted: ^{
        
        @strongify(self)
        
        self.task = [DataManagerShared getSelectedTask];
        
        self.taskTableViewContent = [self.contentManager getTableViewContentForTask: self.task
                                                              forTableViewWithFrame: self.tableViewFrame];
        
        if ( completion )
            completion(YES);
        
    }];
}

- (ProjectTaskStage*) getTaskStage
{
    return self.task.stage;
}

- (BOOL) getTaskState
{
    return self.task.access.boolValue;
}

- (CGFloat) countHeightForCommentCellForIndexPath: (NSIndexPath*) indexPath
{
    TaskRowContent* content = self.taskTableViewContent[indexPath.section][indexPath.row];
    
    // default cell height without any attachments, text views or edit buttons
    CGFloat cellHeight = 40;
    
    // adding text view height, which depends of comment length and device width
    // 10 is gap to the next cell
    cellHeight += content.commentTextViewHeight + 18;
    
    if ( content.containerView )
    {
        CGFloat containerHeight = content.containerView.frame.size.height;
        
        // distance before container
        cellHeight += containerHeight + 20;
    }
    
    return cellHeight;
}

- (CGFloat) countHeightForLogCellForIndexPath: (NSIndexPath*) indexPath
                                 forTableView: (UITableView*) tableView
{
    TaskRowContent* content = self.taskTableViewContent[indexPath.section][indexPath.row];
        
    return content.logContent.cellHeight;
}

- (void) createContentForTableViewWithFrame: (CGRect) frame
{
    self.tableViewFrame = frame;
    
    self.taskTableViewContent = [self.contentManager getTableViewContentForTask: self.task
                                                          forTableViewWithFrame: frame];
}

- (ProjectTask*) getCurrentTask
{
    return self.task;
}

- (NSString*) getTaskNumberTitle
{
    NSUInteger taskNumber = self.task.taskID.integerValue;
    
    return [NSString stringWithFormat: @"Задача #%lu", (unsigned long)taskNumber];
}

- (NSString*) getProjectTitle
{
    ProjectInfo* projInfo = [DataManagerShared getSelectedProjectInfo];
    
    return projInfo.title;
}

- (NSArray*) getSubtasks
{
    return self.task.subTasks.array;
}

- (ProjectTask*) getInfoForCellAtIndexPath: (NSIndexPath*) path
{
    ProjectTask* cellsContentInfo = [self.task.subTasks.array objectAtIndex: path.row - 1];
    
    return cellsContentInfo;
}

- (void) markTaskAsSelected: (NSIndexPath*)          index
             withCompletion: (CompletionWithSuccess) completion
{
    self.selectedSubtask = [self getInfoForCellAtIndexPath: index];
    
    [[TasksService sharedInstance] changeSelectedStageForTask: self.selectedSubtask
                                            withSelectedState: YES
                                               withCompletion: completion];
}

- (void) sortArrayForType: (TasksSortingType)           type
               isAcceding: (ContentAccedingSortingType) isAcceding
{
    NSArray* arrForSort = [self getSubtasks];

   NSArray* sortedArray =  [self applyTasksSortingType: type
                                               toArray: arrForSort
                                            isAcceding: isAcceding];
    
    self.taskTableViewContent = [self.contentManager updateContentWithSortedSubtasks: sortedArray
                                                                          forContent: self.taskTableViewContent];
    
}

- (void) fillSelectedTask: (ProjectTask*)          task
           withCompletion: (CompletionWithSuccess) completion
{
    if (self.isSubtask)
    {
        self.selectedSubtask = task;
    }
    
    else
    {
        self.task = task;
    }

    self.taskTableViewContent = [self.contentManager getTableViewContentForTask: task
                                                          forTableViewWithFrame: self.tableViewFrame];
    
    [self updateSecondSectionContentType: self.secondSectionContentType];
    
    if (completion)
        completion(YES);
}

- (void) reloadDataWithCompletion: (CompletionWithSuccess) completion
{
    [self fillSelectedTask: [[TasksService sharedInstance] getUpdatedSelectedTask]
            withCompletion: completion];
    
    [DefaultNotifyCenter postNotificationName: @"UpdateCellContent"
                                       object: nil];
}

- (ProjectTask*) getSelectedSubtask
{
    return self.selectedSubtask;
}

- (void) fillIsSubtaskState: (BOOL) isSubtask
{
    self.isSubtask = isSubtask;
}

- (BOOL) getIsSubtaskState
{
    return self.isSubtask;
}

#pragma mark - Helpers -

- (void) updateContentWithRow: (TaskRowContent*) newRow
                    inSection: (NSUInteger) section
                        inRow: (NSUInteger) row
{
    NSArray* sectionContent = self.taskTableViewContent[section];
    
    NSMutableArray* contentCopy = [NSMutableArray arrayWithArray: self.taskTableViewContent];
    
    NSMutableArray* sectionCopy = [NSMutableArray arrayWithArray: sectionContent];
    
    [sectionCopy replaceObjectAtIndex: row withObject: newRow];
    
    sectionContent = [sectionCopy copy];
    
    [contentCopy replaceObjectAtIndex: section withObject: sectionContent];
    
    self.taskTableViewContent = [contentCopy copy];
}

@end
