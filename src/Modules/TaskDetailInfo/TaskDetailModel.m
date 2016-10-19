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

//// Helpers
#import "ProjectsEnumerations.h"

@interface TaskDetailModel() <ChangeStatusControllerDelegate>

// properties
@property (strong, nonatomic) ProjectTask* task;

@property (strong, nonatomic) NSArray* taskTableViewContent;

@property (strong, nonatomic) TaskDetailContentManager* contentManager;

@property (assign, nonatomic) TaskInfoSecondSectionContentType secondSectionContentType;

@end

@implementation TaskDetailModel

#pragma mark - Properties -

- (NSArray*) taskTableViewContent
{
    if ( _taskTableViewContent == nil )
    {
        _taskTableViewContent = [self.contentManager getTableViewContentForTask: self.task];
    }
    
    return _taskTableViewContent;
}

- (ProjectTask*) task
{
    if ( _task == nil )
    {
        _task = [DataManagerShared getSelectedTask];
    }
    
    return _task;
}

- (TaskDetailContentManager*) contentManager
{
    if ( _contentManager == nil )
    {
        _contentManager = [TaskDetailContentManager new];
    }
    
    return _contentManager;
}

#pragma mark - Public -

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

- (void) deselectTask
{
    [[TasksService sharedInstance] changeSelectedStageForTask: self.task
                                            withSelectedState: NO];
}

- (NSArray*) returnHeaderNumbersInfo
{
    NSArray* headerInfo = @[ @(self.task.subTasks.count),
                             self.task.attachments,
                             self.task.commentsCount,
                             @(0) ];
    
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

- (void) updateTaskStatus
{
    self.task = [DataManagerShared getSelectedTask];
    
    // row that contains info about first cell in table view
    TaskRowContent* row   = self.taskTableViewContent[0][0];
    
    row.status            = self.task.status.integerValue;
    row.statusDescription = self.task.statusDescription;
    
    // updating content with new status value
    [self updateContentWithRow: row
                     inSection: 0
                         inRow: 0];
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
