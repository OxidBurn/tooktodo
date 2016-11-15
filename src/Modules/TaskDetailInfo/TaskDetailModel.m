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
// Helpers
#import "ProjectsEnumerations.h"

@interface TaskDetailModel()

// properties
@property (strong, nonatomic) ProjectTask* task;

@property (strong, nonatomic) NSArray* taskTableViewContent;

@property (strong, nonatomic) TaskDetailContentManager* contentManager;

@property (assign, nonatomic) TaskInfoSecondSectionContentType secondSectionContentType;

@property (assign, nonatomic) CGRect tableViewFrame;

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

- (void) fillSelectedTask: (ProjectTask*)          task
           withCompletion: (CompletionWithSuccess) completion
{
    self.task = task;
    
    self.taskTableViewContent = [self.contentManager getTableViewContentForTask: task
                                                          forTableViewWithFrame: self.tableViewFrame];
    
    if (completion)
        completion(YES);
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
#warning TookToDo: overwrite method using AddTaskContentManager
//    [self.contentManager update];
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
    
    // default cell height without any attachments or edit buttons
    CGFloat cellHeight = 100;
    
    if ( content.containerView )
    {
        CGFloat containerHeight = content.containerView.frame.size.height;
        
        // distance between cells and distance before container
        cellHeight += containerHeight + 30;
    }
    
    return cellHeight;
}

- (void) createContentForTableViewWithFrame: (CGRect) frame
{
    self.tableViewFrame = frame;
    
    self.taskTableViewContent = [self.contentManager getTableViewContentForTask: self.task
                                                          forTableViewWithFrame: frame];
}

@end
