//
//  TaskDetailContentManager.m
//  TookTODO
//
//  Created by Глеб on 18.10.16.
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
    
    return @[ sectionOne, sectionTwo ] ;
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
    TaskRowContent* rowOne = [TaskRowContent new];
    
    rowOne.cellId              = self.tableViewCellsIdArray[TaskDetailCellType];
    rowOne.cellTypeIndex       = TaskDetailCellType;
   // rowOne.rowHeight           = [self returnFloatFromNumber: self.rowsHeighsArray[TaskDetailCellType]];
    rowOne.taskStartDate       = task.startDay;
    rowOne.taskEndDate         = task.endDate;
    rowOne.isExpired           = task.isExpired;
    rowOne.status              = task.status.integerValue;
    rowOne.taskTypeDescription = task.taskTypeDescription;
    rowOne.workAreaShortTitle  = task.workArea.shortTitle;
    rowOne.taskTitle           = task.title;
    rowOne.statusDescription   = task.statusDescription;
    rowOne.subtasksNumber      = task.subTasks.count;
    rowOne.attachmentsNumber   = task.attachments.integerValue;
    rowOne.roomNumber          = task.room.number.integerValue;
    rowOne.commentsNumber      = task.commentsCount.integerValue;
    
    TaskRowContent* rowTwo = [TaskRowContent new];
    
    rowTwo.cellId          = self.tableViewCellsIdArray[TaskDescriptionCellType];
    rowTwo.cellTypeIndex   = TaskDescriptionCellType;
    //rowTwo.rowHeight       = [self returnFloatFromNumber: self.rowsHeighsArray[TaskDescriptionCellType]];
    rowTwo.taskDescription = task.descriptionValue;
    
    TaskRowContent* rowThree = [TaskRowContent new];
    
    rowThree.cellId    = self.tableViewCellsIdArray[CollectionCellType];
    rowThree.cellTypeIndex = CollectionCellType;
    //rowThree.rowHeight = [self returnFloatFromNumber: self.rowsHeighsArray[CollectionCellType]];
    
    return @[ rowOne, rowTwo, rowThree ];
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
    TaskRowContent* rowOne = [TaskRowContent new];
    
    rowOne.cellId = self.tableViewCellsIdArray[FilterSubtasksCellType];
    rowOne.cellTypeIndex = FilterSubtasksCellType;
    rowOne.rowHeight = 58;
    
    NSArray* testContent = [self createTestSubtaskForTask: task];
    
    NSMutableArray* subtasksTmp = testContent.mutableCopy;
    
    [subtasksTmp insertObject: rowOne
                      atIndex: 0];
    
    return subtasksTmp.copy;
}

- (NSArray*) createAttachmentsContentForTask: task
{
    TaskRowContent* rowOne = [TaskRowContent new];
    
    rowOne.cellId = self.tableViewCellsIdArray[FilterAttachmentsCellType];
    rowOne.cellTypeIndex = FilterAttachmentsCellType;
    rowOne.rowHeight = 58;
    
    NSArray* testContent = [self createTestAttachmentForTask: task];
    
    NSMutableArray* attachmentsTmp = testContent.mutableCopy;
    
    // this code will be used with real data
    //    if ( self.task.attachments )
    //    {
    //        for (int i = 0; i < self.task.attachments.intValue; i++)
    //        {
    //            TaskRowContent* newRow = [TaskRowContent new];
    //
    //            newRow.cellId    = self.tableViewCellsIdArray[AttachmentsCell];
    //            newRow.rowHeight = 54;
    //
    //            [attachmentsTmp addObject: newRow];
    //
    //            // here content will be filled
    //        }
    //    }
    
    [attachmentsTmp insertObject:
     rowOne atIndex: 0];
    
    return attachmentsTmp.copy;
}

- (NSArray*) createCommentsContentForTask: task
{
    TaskRowContent* rowOne = [TaskRowContent new];
    
    rowOne.cellId = self.tableViewCellsIdArray[AddCommentCellType];
    rowOne.cellTypeIndex = AddCommentCellType;
    rowOne.rowHeight = 61;
    
    NSArray* testContent = [self createTestComment];
    
    NSMutableArray* commentsTmp = testContent.mutableCopy;
    
    // this code will be used with real data
    //    if ( self.task.commentsCount )
    //    {
    //        for (int i = 0; i < self.task.commentsCount.intValue; i++)
    //        {
    //            TaskRowContent* newRow = [TaskRowContent new];
    //
    //            newRow.cellId    = self.tableViewCellsIdArray[CommentsCell];
    //            newRow.rowHeight = 129;
    //
    //            [commentsTmp addObject: newRow];
    //
    //            // here content will be filled
    //        }
    //    }
    
    [commentsTmp insertObject:
     rowOne atIndex: 0];
    
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
    subtask.rowHeight = 137;
    
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
    attachment.rowHeight = 54;
    
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
    comment.rowHeight = 129;
    
    comment.commentAuthorName = @"Тестовый Пользователь";
    comment.commentAuthorAvatar = [UIImage imageNamed: @"UserMark"];
    comment.commentDate         = [NSDate date];
    
    comment.commentText = @"Обычно тут что-то совершенно непонятное, вот и я не стал нарушать традиции";
    
    return @[comment];
}

@end
