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
#import "AttachmentView.h"
#import "FlexibleViewsContainer.h"

#import "ProjectTask+CoreDataProperties.h"
#import "TaskComment+CoreDataProperties.h"

#import "Utils.h"

// Test class import
#import "TestAttachments.h"

@interface TaskDetailContentManager()

// properties
@property (strong, nonatomic) NSArray* tableViewCellsIdArray;

@property (assign, nonatomic) CGRect tableViewFrame;

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
                  forTableViewWithFrame: (CGRect)       tableViewFrame
{
    self.tableViewFrame = tableViewFrame;
    
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
    taskDetailCellContent.isExpired           = task.isExpired.boolValue;
    taskDetailCellContent.status              = task.status.integerValue;
    taskDetailCellContent.taskTypeDescription = task.taskTypeDescription;
    taskDetailCellContent.workAreaShortTitle  = task.workArea.shortTitle;
    taskDetailCellContent.taskTitle           = task.title;
    taskDetailCellContent.statusDescription   = task.statusDescription;
    taskDetailCellContent.subtasksNumber      = task.subTasks.count;
    taskDetailCellContent.attachmentsNumber   = task.attachments.integerValue;
    taskDetailCellContent.roomNumber          = task.room.number.integerValue;
    taskDetailCellContent.commentsNumber      = task.commentsCount.integerValue;
    taskDetailCellContent.taskType            = task.taskType.integerValue;
    
    TaskRowContent* taskDescriptionCellContent = [TaskRowContent new];
    
    taskDescriptionCellContent.cellId          = self.tableViewCellsIdArray[TaskDescriptionCellType];
    taskDescriptionCellContent.cellTypeIndex   = TaskDescriptionCellType;
    taskDescriptionCellContent.taskDescription = task.descriptionValue;
    
    TaskRowContent* collectionCellContent = [TaskRowContent new];
    
    collectionCellContent.cellId          = self.tableViewCellsIdArray[CollectionCellType];
    collectionCellContent.cellTypeIndex   = CollectionCellType;
    
    NSArray* sectionOne = @[taskDetailCellContent, taskDescriptionCellContent, collectionCellContent];
    
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
    
    NSArray* content        = [self createSubtaskForTask: task];
    
    NSMutableArray* subtasksTmp = content.mutableCopy;
    
    [subtasksTmp insertObject: filterSubtaskCellContent
                      atIndex: 0];
    
    return subtasksTmp.copy;
}


- (NSArray*) updateContentWithSortedSubtasks: (NSArray*) sortedArray
                                  forContent: (NSArray*) content
{
    NSArray* newSubtaskContent = [self fillSubtasksContent: sortedArray];
    
    NSMutableArray* tmpContent = content.mutableCopy;
    
    TaskRowContent* firstRow = tmpContent[1][0];
    
    NSMutableArray* tmpSubtasksContent = newSubtaskContent.mutableCopy;
    
    [tmpSubtasksContent insertObject: firstRow
                             atIndex: 0];
    
    [tmpContent replaceObjectAtIndex: 1
                          withObject: tmpSubtasksContent.copy];
    
    return tmpContent.copy;
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
    
    NSArray* testContent        = [NSArray new];
    
    if ( [task comments].count == 0 )
        testContent = [self createTestComment];
    
    NSMutableArray* commentsTmp = testContent.mutableCopy;
    
    NSNumber* numberOfComments = [task commentsCount];
    
        if ( [task comments] && [task commentsCount] )
        {
            for (int i = 0; i < numberOfComments.integerValue; i++)
            {
                TaskComment* comment = [[task comments] objectAtIndex: i];
                
                TaskRowContent* newRow = [TaskRowContent new];
                
                newRow.commentText            = comment.message;
                newRow.commentAuthorName      = comment.author;
                newRow.commentAuthorAvatarSrc = comment.avatarSrc;
                newRow.commentDate            = comment.date;
    
                newRow.cellId    = self.tableViewCellsIdArray[CommentsCellType];
                newRow.cellTypeIndex = CommentsCellType;
                
                newRow.commentTextViewHeight  = [self countTextViewHeightForString: comment.message] + 20;
    
                [commentsTmp addObject: newRow];
            }
        }
    
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


- (NSArray*) createAttachmentsViewsWithTitles: (NSArray*) attachmentsArray
{
    __block NSMutableArray* viewsArray = [NSMutableArray new];
    
    [attachmentsArray enumerateObjectsUsingBlock: ^(NSString* title, NSUInteger idx, BOOL * _Nonnull stop) {
        
        AttachmentView* view = [[[NSBundle mainBundle] loadNibNamed: @"AttachmentView"
                                                              owner: nil
                                                            options: nil] lastObject];
        
        [view fillViewWithAttachmentName: title];
        
        [viewsArray addObject: view];
    }];
    
    return viewsArray.copy;
}


#pragma mark - Helpers -

- (CGFloat) returnFloatFromNumber: (NSNumber*) number
{
    return number.floatValue;
}


- (NSArray*) createSubtaskForTask: (ProjectTask*) task
{
    NSArray* subtasksArray = task.subTasks.allObjects;
 
    return [self fillSubtasksContent: subtasksArray];
}

- (CGFloat) countTextViewHeightForString: (NSString*) string
{
    UIFont* font = [UIFont fontWithName: @"Lato-Regular" size: 13.f];

    CGSize size = [Utils findHeightForText: string
                               havingWidth: self.tableViewFrame.size.width - 30
                                   andFont: font];
    
    CGFloat height = size.height;
    
    if (height > 69)
        height = 69;
    
    return height;
}

#pragma mark - Test methods -


- (NSArray*) fillSubtasksContent: (NSArray*) subtasksArray
{
    __block NSMutableArray* subtasksTmp = [NSMutableArray array];
    
    [subtasksArray enumerateObjectsUsingBlock: ^(ProjectTask*  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        TaskRowContent* subtask = [TaskRowContent new];
        
        subtask.taskStartDate       = obj.startDay;
        subtask.taskEndDate         = obj.endDate;
        subtask.isExpired           = obj.isExpired.boolValue;
        subtask.status              = obj.status.integerValue;
        subtask.taskTypeDescription = obj.taskTypeDescription;
        subtask.workAreaShortTitle  = obj.workArea.shortTitle;
        subtask.taskTitle           = obj.title;
        subtask.statusDescription   = obj.statusDescription;
        subtask.subtasksNumber      = obj.subTasks.count;
        subtask.attachmentsNumber   = obj.attachments.integerValue;
        subtask.roomNumber          = obj.room.number.integerValue;
        subtask.commentsNumber      = obj.commentsCount.integerValue;
        subtask.taskType            = obj.taskType.integerValue;
        
        subtask.cellId = self.tableViewCellsIdArray[SubtaskInfoCellType];
        
        [subtasksTmp addObject: subtask];
        
    }];
    
    
    return subtasksTmp.copy;
}


#pragma mark - Test methods -

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
    
    comment.cellTypeIndex = CommentsCellType;
    
    comment.commentAuthorName = @"Тестовый Пользователь";
    comment.commentAuthorAvatar = [UIImage imageNamed: @"UserMark"];
    comment.commentDate         = [NSDate date];
    
    comment.commentText = @"Комментарии будут жить здесь с прикрепленными файлами или без. Небходим достаточно длинный текст чтобы проверить правильность заполнения ячейки";
    
    comment.commentTextViewHeight = [self countTextViewHeightForString: comment.commentText] + 20;
    
    NSArray* attachmentsTitlesArray = [TestAttachments returnArrayWithAttachments];
    
    NSArray* attachmentsArray = [self createAttachmentsViewsWithTitles: attachmentsTitlesArray];
    
    CGRect containerFrame = CGRectMake(0,
                                       0,
                                       self.tableViewFrame.size.width - 30,
                                       20);
    
    FlexibleViewsContainer* container = [[FlexibleViewsContainer alloc] initWithFrame: containerFrame];
    
    [container fillViewsContainerWithViews: attachmentsArray
                                  forWidth: containerFrame.size.width];
    
    comment.containerView = container;
    
    TaskRowContent* anotherComment = [TaskRowContent new];
    
    anotherComment.cellId = self.tableViewCellsIdArray[CommentsCellType];
    
    anotherComment.cellTypeIndex = CommentsCellType;
    
    anotherComment.commentAuthorName = @"Немногословный Юзер";
    anotherComment.commentAuthorAvatar = [UIImage imageNamed: @"UserMark"];
    anotherComment.commentDate         = [NSDate date];
    
    anotherComment.commentText = @"Буду краток...";
    
    anotherComment.commentTextViewHeight = [self countTextViewHeightForString: anotherComment.commentText] + 20;
    
    return @[comment, anotherComment];
}



@end
