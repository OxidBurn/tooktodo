//
//  TaskDetailContentManager.m
//  TookTODO
//
//  Created by Chaban Nikolay on 18.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskDetailContentManager.h"

// Classes
#import "ProjectTaskRoomLevel+CoreDataClass.h"
#import "ProjectTaskWorkArea.h"
#import "TaskRowContent.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "TasksService.h"

@interface TaskDetailContentManager()

// properties
@property (strong, nonatomic) NSArray* tableViewCellsIdArray;

@end

@implementation TaskDetailContentManager

#pragma mark - Properties -

- (NSArray*) tableViewCellsIdArray
{
    if ( _tableViewCellsIdArray == nil )
    {
        _tableViewCellsIdArray = @[ @"TaskDetailInfoCellId",
                                    @"TaskDescriptionCellId",
                                    @"CollectionCellId",
                                    @"SubtaskInfoCellId",
                                    @"AttachmentsCellId",
                                    @"CommentsCellId",
                                    @"LogWithActionCellId",
                                    @"LogWithDetailCellId",
                                    @"LogCellId",
                                    @"FilterSubtasksCellId",
                                    @"FilterAttachmentsCellId",
                                    @"AddCommentCellId" ];
    }
    
    return _tableViewCellsIdArray;
}

#pragma mark - Public -

- (NSArray*) getTableViewContentForTask: (ProjectTask*) task
{
    NSArray* sectionOne = [self createSectionOneForTask: task];
    
    NSArray* sectionTwo = [self createSectionTwoForTask: task];
    
    NSArray* content    = @[ sectionOne, sectionTwo ];
    
    return content;
}

- (NSArray*) createSectionTwoContentAccordingToType: (NSUInteger)   typeIndex
                                            forTask: (ProjectTask*) task
{
    NSArray* content = [NSArray new];
    
    switch ( typeIndex )
    {
        case SubtasksContentType:
        {
            content = [self createSubtasksContentForTask: task];
        }
            break;
            
        case AttachmentsContentType:
        {
            content = [self createAttachmentsContentForTask: task];
        }
            break;
            
        case CommentsContentType:
        {
            content = [self createCommentsContentForTask: task];
        }
            break;
            
        case LogsContentType:
        {
            content = [self createSLogsContentForTask: task];
        }
            break;
            
        default:
            break;
    }
    
    return content;
}

#pragma mark - Internal -

- (NSArray*) createSectionOneForTask: (ProjectTask*) task
{
    TaskRowContent* taskDetailCellContent = [TaskRowContent new];
    
    taskDetailCellContent.cellId              = self.tableViewCellsIdArray[TaskDetailCellType];
    taskDetailCellContent.cellTypeIndex       = TaskDetailCellType;
    taskDetailCellContent.taskStartDate       = task.startDay;
    taskDetailCellContent.taskEndDate         = task.endDate;
    taskDetailCellContent.isExpired           = task.isExpired;
    taskDetailCellContent.status              = task.status.integerValue;
    taskDetailCellContent.taskTypeDescription = task.taskTypeDescription;
    taskDetailCellContent.workAreaShortTitle  = task.workArea.shortTitle;
    taskDetailCellContent.taskTitle           = task.title;
    taskDetailCellContent.statusDescription   = task.statusDescription;
    taskDetailCellContent.subtasksNumber      = task.subTasks.count;
    taskDetailCellContent.attachmentsNumber   = task.attachments.integerValue;
    taskDetailCellContent.roomNumber          = task.room.number.integerValue;
    taskDetailCellContent.commentsNumber      = task.commentsCount.integerValue;
    
    TaskRowContent* taskDescriptionCellContent = [TaskRowContent new];
    
    taskDescriptionCellContent.cellId          = self.tableViewCellsIdArray[TaskDescriptionCellType];
    taskDescriptionCellContent.cellTypeIndex   = TaskDescriptionCellType;
    taskDescriptionCellContent.taskDescription = task.descriptionValue;
    
    TaskRowContent* collectionCellContent = [TaskRowContent new];
    
    collectionCellContent.cellId          = self.tableViewCellsIdArray[CollectionCellType];
    collectionCellContent.cellTypeIndex   = CollectionCellType;
    
    NSArray* sectionOne = @[ taskDetailCellContent, taskDescriptionCellContent, collectionCellContent ];
    
    return sectionOne;
}

- (NSArray*) createSectionTwoForTask: (ProjectTask*) task
{
    // default second section content type is SubtasksContentType
    NSArray* content = [self createSectionTwoContentAccordingToType: SubtasksContentType
                                                            forTask: task];
    
    return content.copy;
}

- (NSArray*) createSubtasksContentForTask: (ProjectTask*) task
{
    TaskRowContent* filterSubtaskCellContent = [TaskRowContent new];
    
    filterSubtaskCellContent.cellId        = self.tableViewCellsIdArray[FilterSubtasksCellType];
    filterSubtaskCellContent.cellTypeIndex = FilterSubtasksCellType;
    
    NSArray* testContent        = [self createTestSubtaskForTask: task];
    
    NSMutableArray* subtasksTmp = testContent.mutableCopy;
    
    [subtasksTmp insertObject: filterSubtaskCellContent
                      atIndex: 0];
    
    return subtasksTmp.copy;
}

- (NSArray*) createAttachmentsContentForTask: task
{
    TaskRowContent* filterAttachmentsCellContent = [TaskRowContent new];
    
    filterAttachmentsCellContent.cellId        = self.tableViewCellsIdArray[FilterAttachmentsCellType];
    filterAttachmentsCellContent.cellTypeIndex = FilterAttachmentsCellType;
    
    NSArray* testContent           = [self createTestAttachmentForTask: task];
    
    NSMutableArray* attachmentsTmp = testContent.mutableCopy;
    
    // this code will be used with real data
    //    if ( self.task.attachments )
    //    {
    //        for (int i = 0; i < self.task.attachments.intValue; i++)
    //        {
    //            TaskRowContent* newRow = [TaskRowContent new];
    //
    //            newRow.cellId    = self.tableViewCellsIdArray[AttachmentsCell];
    //
    //            [attachmentsTmp addObject: newRow];
    //
    //            // here content will be filled
    //        }
    //    }
    
    [attachmentsTmp insertObject: filterAttachmentsCellContent
                         atIndex: 0];
    
    return attachmentsTmp.copy;
}

- (NSArray*) createCommentsContentForTask: task
{
    TaskRowContent* addCommentCellContent = [TaskRowContent new];
    
    addCommentCellContent.cellId        = self.tableViewCellsIdArray[AddCommentCellType];
    addCommentCellContent.cellTypeIndex = AddCommentCellType;
    
    NSArray* testContent        = [self createTestComment];
    
    NSMutableArray* commentsTmp = testContent.mutableCopy;
    
    // this code will be used with real data
    //    if ( self.task.commentsCount )
    //    {
    //        for (int i = 0; i < self.task.commentsCount.intValue; i++)
    //        {
    //            TaskRowContent* newRow = [TaskRowContent new];
    //
    //            newRow.cellId    = self.tableViewCellsIdArray[CommentsCell];
    //
    //            [commentsTmp addObject: newRow];
    //
    //            // here content will be filled
    //        }
    //    }
    
    [commentsTmp insertObject: addCommentCellContent
                      atIndex: 0];
    
    return commentsTmp.copy;
}

- (NSArray*) createSLogsContentForTask: task
{
    NSArray* content = [NSArray new];
    
    // here will be created content with logs
    
    return content;
}
#pragma mark - Helpers -

- (CGFloat) returnFloatFromNumber: (NSNumber*) number
{
    return number.floatValue;
}

#pragma mark - Test methods -

- (NSArray*) createTestSubtaskForTask: (ProjectTask*) task
{
    TaskRowContent* subtask = [TaskRowContent new];
    
    subtask.cellId = self.tableViewCellsIdArray[SubtaskInfoCellType];
    
    subtask.taskStartDate       = task.startDay;
    subtask.taskEndDate         = task.endDate;
    subtask.isExpired           = task.isExpired;
    subtask.status              = task.status.integerValue;
    subtask.taskTypeDescription = task.taskTypeDescription;
    subtask.workAreaShortTitle  = task.workArea.shortTitle;
    subtask.taskTitle           = task.title;
    subtask.statusDescription   = task.statusDescription;
    subtask.subtasksNumber      = task.subTasks.count;
    subtask.attachmentsNumber   = task.attachments.integerValue;
    subtask.roomNumber          = task.room.number.integerValue;
    subtask.commentsNumber      = task.commentsCount.integerValue;
    
    return @[subtask];
}

- (NSArray*) createTestAttachmentForTask: task
{
    TaskRowContent* attachment = [TaskRowContent new];
    
    attachment.cellId = self.tableViewCellsIdArray[AttachmentsCellType];
    
    attachment.attachmentTitle = @"Тестовый прикрепленный документ.пэдээф";
    attachment.attachmentImage = [UIImage imageNamed: @"NoteMark"];
    attachment.taskStartDate   = [NSDate date];
    attachment.taskEndDate     = [NSDate dateWithTimeIntervalSinceNow: 90000];
    
    return @[attachment];
}

- (NSArray*) createTestComment
{
    TaskRowContent* comment = [TaskRowContent new];
    
    comment.cellId = self.tableViewCellsIdArray[CommentsCellType];
    
    comment.commentAuthorName = @"Тестовый Пользователь";
    comment.commentAuthorAvatar = [UIImage imageNamed: @"UserMark"];
    comment.commentDate         = [NSDate date];
    
    comment.commentText = @"Обычно тут что-то совершенно непонятное, вот и я не стал нарушать традиции";
    
    return @[comment];
}

@end