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
#import "ProjectTaskRoomLevel+CoreDataClass.h"
#import "ProjectTaskWorkArea.h"
#import "TaskRowContent.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "ProjectsEnumerations.h"
#import "ChangeStatusViewController.h"
#import "TasksService.h"

// Helpers
#import "Utils.h"

// Factories
#import "TaskDetailInfoFactory.h"
#import "TaskDescriptionFactory.h"
#import "CollectionCellFactory.h"
#import "FilterSubtaskCellFactory.h"
#import "FilterAttachmentsCellFactory.h"
#import "AddCommentCellFactory.h"
#import "SubtaskInfoFactory.h"
#import "AttachmentsCellFactory.h"
#import "CommentsCellFactory.h"

typedef NS_ENUM(NSUInteger, TaskTableViewCells) {
    
    TaskDetailCell,
    TaskDescriptionCell,
    CollectionCell,
    SubtaskInfoCell,
    AttachmentsCell,
    CommentsCell,
    LogWithActionCell,
    LogWithDetailCell,
    LogCell,
    FilterSubtasksCell,
    FilterAttachmentsCell,
    AddCommentCell,
    
};

typedef NS_ENUM(NSUInteger, SectionsList) {
    
    SectionOne,
    SectionTwo,
    SectionThree,
    
};

typedef NS_ENUM(NSUInteger, RowsTypeSectionOne) {
    
    TaskNameRow,
    TaskDescriptionRow,
    TaskHiddenStatusRow,
    CollectionRow,
    
};


@interface TaskDetailModel() <ChangeStatusControllerDelegate>

// properties
@property (strong, nonatomic) ProjectTask* task;

@property (strong, nonatomic) NSArray* taskTableViewContent;

@property (strong, nonatomic) NSArray* tableViewCellsIdArray;

@property (strong, nonatomic) NSArray* rowsHeighsArray;

@property (assign, nonatomic) TaskInfoSecondSectionContentType secondSectionContentType;


// methods


@end

@implementation TaskDetailModel

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

- (NSArray*) taskTableViewContent
{
    if ( _taskTableViewContent == nil )
    {
        _taskTableViewContent = [self returnTableViewContent];
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


- (NSArray*) rowsHeighsArray
{
    if ( _rowsHeighsArray == nil )
    {
        _rowsHeighsArray = @[ @(162), @(58), @(232) ,@(58),  @(58) ];
    }
    
    return _rowsHeighsArray;
}

#pragma mark - Public -

- (TaskStatusType) getTaskStatus
{
    return self.task.status.integerValue;
}


- (NSUInteger) returnNumberOfRowsForIndexPath: (NSInteger) section
{
    NSArray* sectionContent = self.taskTableViewContent[section];
    
    return sectionContent.count;
}

- (CGFloat) returnHeigtForRowAtIndexPath: (NSIndexPath*) indexPath
                            forTableView: (UITableView*) tableView
{
    CGFloat height;
    
    TaskRowContent* row = self.taskTableViewContent[indexPath.section][indexPath.row];
    
    height = row.rowHeight;
    
    if ( indexPath.section == 0 && indexPath.row == 0)
    {
        // height without label in first cell is 119
        height = 119;
        
        NSString* taskTitle = [self.task title];
        
        CGSize labelSize = [Utils findHeightForText: taskTitle
                                        havingWidth: tableView.frame.size.width - 30
                                            andFont: [UIFont fontWithName: @"SFUIDisplay-Regular"
                                                                     size: 22.f]];
        
        // limiting label height for 2 rows only
        if ( labelSize.height > 54 )
        {
            labelSize.height = 54;
        }
        
        height = height + labelSize.height;
    }
    
    if ( indexPath.section == 0 && indexPath.row == 1 )
    {
        // 54 - height without label is row height value if description value == nil
        CGFloat heightWithoutLabel = 54;
        
        NSString* desriptionValue = [self.task descriptionValue];
        
        CGSize labelSize = [Utils findHeightForText: desriptionValue
                                        havingWidth: tableView.frame.size.width - 30
                                            andFont: [UIFont fontWithName: @"SFUIText-Regular"
                                                                     size: 13.f]];
        // 79pt - heihgt for 5 rows label with current font
        // if desciption is larger than 5 row we limit label height manually
        if ( labelSize.height > 79 )
            labelSize.height = 79;
        
        height = labelSize.height + heightWithoutLabel;
        
        if ( desriptionValue == nil )
        {
            // 16 - height for one row
            height = height + 16;
        }
    }
    
    return height;
}

- (UITableViewCell*) createCellForTableView: (UITableView*) tableView
                               forIndexPath: (NSIndexPath*) indexPath
{
    NSArray* section = self.taskTableViewContent[indexPath.section];
    
    TaskRowContent* content = section[indexPath.row];
    
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    
    NSString* cellID = content.cellId;
    
    NSUInteger cellTypeIndex = [self.tableViewCellsIdArray indexOfObject: cellID];
    
    switch ( cellTypeIndex )
    {
        case TaskDetailCell:
        {
            TaskDetailInfoFactory* factory = [TaskDetailInfoFactory new];
            
            cell = [factory returnTaskDetailCellWithContent: content
                                               forTableView: tableView];
            
        }
            break;
            
        case TaskDescriptionCell:
        {
            TaskDescriptionFactory* factory = [TaskDescriptionFactory new];
            
            cell = [factory returnDescriptionCellWithContent: content
                                                forTableView: tableView];
        }
            break;
            
        case CollectionCell:
        {
            CollectionCellFactory* factory = [CollectionCellFactory new];
            
            cell = [factory returnCellectionCellForTableView: tableView];
        }
            break;
            
        case FilterSubtasksCell:
        {
            FilterSubtaskCellFactory* factory = [FilterSubtaskCellFactory new];
            
            cell = [factory returnFilterSubtasksCellForTableView: tableView];
            
        }
            break;
            
        case FilterAttachmentsCell:
        {
            FilterAttachmentsCellFactory* factory = [FilterAttachmentsCellFactory new];
            
            cell = [factory returnFilterAttachmentsCellForTableView: tableView];
        }
            break;
            
        case AddCommentCell:
        {
            AddCommentCellFactory* factory = [AddCommentCellFactory new];
            
            cell = [factory returnAddCommentCellForTableView: tableView];
        }
            break;
            
        case SubtaskInfoCell:
        {
            SubtaskInfoFactory* factory = [SubtaskInfoFactory new];
            
            cell = [factory returnSubtaskInfoCellForTableView: tableView
                                                  withContent: content];
            
        }
            break;
            
        case AttachmentsCell:
        {
            AttachmentsCellFactory* factory = [AttachmentsCellFactory new];
            
            cell = [factory returnAttachmentsCellForTableView: tableView
                                                  withContent: content];
        }
            break;
            
        case CommentsCell:
        {
            CommentsCellFactory* factory = [CommentsCellFactory new];
            
            cell = [factory returnCommentsCellForTableView: tableView
                                               withContent: content];
        }
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void) deselectTask
{
    [[TasksService sharedInstance] changeSelectedStageForTask: self.task
                                            withSelectedState: NO];
}

- (NSArray*) returnHeaderInfo
{
    NSArray* headerInfo = @[ @(self.task.subTasks.count),
                             self.task.attachments,
                             self.task.commentsCount,
                             @(0) ];
    
    return headerInfo;
}

- (UIView*) returnHeaderForSection
{
    UIView* header = [UIView new];
    
    switch ( self.secondSectionContentType )
    {
        case SubtasksContentType:
        {
                header = [[MainBundle loadNibNamed: @"SubTaskFilter"
                                             owner: self
                                           options: nil] firstObject];
        }
            break;
            
        case AttachmentsContentType:
        {
                header = [[MainBundle loadNibNamed: @"AttachmentsFilter"
                                             owner: self
                                           options: nil] firstObject];
        }
            break;
            
        case CommentsContentType:
        {
                header = [[MainBundle loadNibNamed: @"AddCommentView"
                                             owner: self
                                           options: nil] firstObject];
        }
            break;
            
        default:
            break;
    }
    
    return header;
}

- (CGFloat) returnHeaderHeight
{
    return 43.f;
}

- (void) updateSecondSectionContentType: (NSUInteger) typeIndex
{
    self.secondSectionContentType = typeIndex;
    
    NSArray* newSectionTwo = [self createSectionTwoContentAccordingToType];
    
    NSMutableArray* contentCopy = self.taskTableViewContent.mutableCopy;
    
    [contentCopy replaceObjectAtIndex: 1
                           withObject: newSectionTwo];
    
    self.taskTableViewContent = contentCopy.copy;
}

- (void) updateTaskStatus
{
    self.task = [DataManagerShared getSelectedTask];
    
    // row that contains info about first cell in table view
    TaskRowContent* row = self.taskTableViewContent[0][0];
    
    row.status            = self.task.status.integerValue;
    row.statusDescription = self.task.statusDescription;
    
    // updating content with new status value
    [self updateContentWithRow: row
                     inSection: 0
                         inRow: 0];
}

#pragma mark - Internal -

- (NSArray*) returnTableViewContent
{
    NSArray* sectionOne = [self createSectionOne];
    
    NSArray* sectionTwo = [self createSectionTwo];
    
    return @[ sectionOne, sectionTwo ] ;
}

- (NSArray*) createSectionOne
{
    TaskRowContent* rowOne = [TaskRowContent new];
    
    rowOne.cellId              = self.tableViewCellsIdArray[TaskDetailCell];
    rowOne.rowHeight           = [self returnFloatFromNumber: self.rowsHeighsArray[TaskDetailCell]];
    rowOne.taskStartDate       = self.task.startDay;
    rowOne.taskEndDate         = self.task.endDate;
    rowOne.isExpired           = self.task.isExpired;
    rowOne.status              = self.task.status.integerValue;
    rowOne.taskTypeDescription = self.task.taskTypeDescription;
    rowOne.workAreaShortTitle  = self.task.workArea.shortTitle;
    rowOne.taskTitle           = self.task.title;
    rowOne.statusDescription   = self.task.statusDescription;
    rowOne.subtasksNumber      = self.task.subTasks.count;
    rowOne.attachmentsNumber   = self.task.attachments.integerValue;
    rowOne.roomNumber          = self.task.room.number.integerValue;
    rowOne.commentsNumber      = self.task.commentsCount.integerValue;
    
    TaskRowContent* rowTwo = [TaskRowContent new];
    
    rowTwo.cellId          = self.tableViewCellsIdArray[TaskDescriptionCell];
    rowTwo.rowHeight       = [self returnFloatFromNumber: self.rowsHeighsArray[TaskDescriptionCell]];
    rowTwo.taskDescription = self.task.descriptionValue;
    
    TaskRowContent* rowThree = [TaskRowContent new];
    
    rowThree.cellId    = self.tableViewCellsIdArray[CollectionCell];
    rowThree.rowHeight = [self returnFloatFromNumber: self.rowsHeighsArray[CollectionCell]];
        
    return @[ rowOne, rowTwo, rowThree ];
}

- (NSArray*) createSectionTwo
{
    NSArray* content = [self createSectionTwoContentAccordingToType];
    
    return content.copy;
}

- (NSArray*) createSectionTwoContentAccordingToType
{
    NSArray* content = [NSArray new];
    
    switch ( self.secondSectionContentType )
    {
        case SubtasksContentType:
        {
            content = [self createSubtasksContent];
        }
            break;
            
        case AttachmentsContentType:
        {
            content = [self createAttachmentsContent];
        }
            break;
            
        case CommentsContentType:
        {
            content = [self createCommentsContent];
        }
            break;
            
        case LogsContentType:
        {
            content = [self createSLogsContent];
        }
            break;
            
        default:
            break;
    }
    
    return content;
}

- (NSArray*) createSubtasksContent
{
    TaskRowContent* rowOne = [TaskRowContent new];
    
    rowOne.cellId = self.tableViewCellsIdArray[FilterSubtasksCell];
    rowOne.rowHeight = 58;
    
    NSArray* testContent = [self createTestSubtask];
    
    NSMutableArray* subtasksTmp = testContent.mutableCopy;
    
    [subtasksTmp insertObject: rowOne
                      atIndex: 0];
    
    return subtasksTmp.copy;
}

- (NSArray*) createAttachmentsContent
{
    TaskRowContent* rowOne = [TaskRowContent new];
    
    rowOne.cellId = self.tableViewCellsIdArray[FilterAttachmentsCell];
    rowOne.rowHeight = 58;
    
    NSArray* testContent = [self createTestAttachment];
    
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

- (NSArray*) createCommentsContent
{
    TaskRowContent* rowOne = [TaskRowContent new];
    
    rowOne.cellId = self.tableViewCellsIdArray[AddCommentCell];
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

- (NSArray*) createSLogsContent
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

#pragma mark - Test methods -

- (NSArray*) createTestSubtask
{
    TaskRowContent* subtask = [TaskRowContent new];
    
    subtask.cellId = self.tableViewCellsIdArray[SubtaskInfoCell];
    subtask.rowHeight = 137;

    subtask.taskStartDate       = self.task.startDay;
    subtask.taskEndDate         = self.task.endDate;
    subtask.isExpired           = self.task.isExpired;
    subtask.status              = self.task.status.integerValue;
    subtask.taskTypeDescription = self.task.taskTypeDescription;
    subtask.workAreaShortTitle  = self.task.workArea.shortTitle;
    subtask.taskTitle           = self.task.title;
    subtask.statusDescription   = self.task.statusDescription;
    subtask.subtasksNumber      = self.task.subTasks.count;
    subtask.attachmentsNumber   = self.task.attachments.integerValue;
    subtask.roomNumber          = self.task.room.number.integerValue;
    subtask.commentsNumber      = self.task.commentsCount.integerValue;
    
    return @[subtask];
}

- (NSArray*) createTestAttachment
{
    TaskRowContent* attachment = [TaskRowContent new];
    
    attachment.cellId = self.tableViewCellsIdArray[AttachmentsCell];
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
    
    comment.cellId = self.tableViewCellsIdArray[CommentsCell];
    comment.rowHeight = 129;
    
    comment.commentAuthorName = @"Тестовый Пользователь";
    comment.commentAuthorAvatar = [UIImage imageNamed: @"UserMark"];
    comment.commentDate         = [NSDate date];
    
    comment.commentText = @"Обычно тут что-то совершенно непонятное, вот и я не стал нарушать традиции";
    
    return @[comment];
}

@end
