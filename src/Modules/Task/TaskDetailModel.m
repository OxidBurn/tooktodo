//
//  TaskModel.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
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

// Helpers
#import "Utils.h"

// Factories
#import "TaskDetailInfoFactory.h"
#import "TaskDescriptionFactory.h"
#import "CollectionCellFactory.h"
#import "TaskOptionsFactory.h"

typedef NS_ENUM(NSUInteger, TaskTableViewCells) {
    
    TaskDetailCell,
    TaskDescriptionCell,
    CollectionCell,
    TaskOptionsCell,
    SubtaskInfoCell,
    
};

typedef NS_ENUM(NSUInteger, SecondSectionContentType) {

    SubtasksContentType,
    AttachmentsContentType,
    CommentsContentType,
    LogsContentType,
    
};


@interface TaskDetailModel()

// properties
@property (strong, nonatomic) ProjectTask* task;

@property (strong, nonatomic) NSArray* taskTableViewContent;

@property (strong, nonatomic) NSArray* tableViewCellsIdArray;

@property (strong, nonatomic) NSArray* rowsHeighsArray;

@property (assign, nonatomic) SecondSectionContentType secondSectionContentType;


// methods


@end

@implementation TaskDetailModel

#pragma mark - Properties -

- (NSArray*) tableViewCellsIdArray
{
    if ( _tableViewCellsIdArray == nil )
    {
        _tableViewCellsIdArray = @[ @"TaskDetailInfoCellId", @"TaskDescriptionCellId", @"CollectionCellId", @"TaskOptionsCellId", @"SubtaskInfoCellId" ];
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
    
    if ( indexPath.section == 0 && indexPath.row == 1 )
    {
        // height without label is row height value if description value == nil
        CGFloat heightWithoutLabel = 35;
        
        CGSize labelSize = [Utils findHeightForText: self.task.taskDescription
                                        havingWidth: tableView.frame.size.width - 30
                                            andFont: [UIFont fontWithName: @"SF UI Text Regular"
                                                                     size: 13.f]];
        height = labelSize.height + heightWithoutLabel;
        
        if ( self.task.taskDescription == nil )
        {
            height = height + 23;
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
            
        case TaskOptionsCell:
        {
            TaskOptionsFactory* factory = [TaskOptionsFactory new];
            
            cell = [factory returnTaskOptionsCellForContent: content
                                               forTableView: tableView];
        }
            break;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void) deselectTask
{
    [DataManagerShared updateSelectedStateForTask: self.task
                                withSelectedState: NO];
}

- (NSArray*) returnFooterInfo
{
    NSArray* headerInfo = @[ @(self.task.subTasks.count),
                             self.task.attachments,
                             @(0),
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
    CGFloat height = 0;
    
    switch ( self.secondSectionContentType )
    {
        case SubtasksContentType:
        case AttachmentsContentType:
            height = 58;
            break;
            
        case CommentsContentType:
            height = 60;
            break;
            
        default:
            break;
    }
    
    return height;
}

- (void) updateSecondSectionContentType: (NSUInteger) typeIndex
{
    self.secondSectionContentType = typeIndex;
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
    NSArray* content = [NSArray new];
    
    // here will be created content with subtasks
    
    return content;
}

- (NSArray*) createAttachmentsContent
{
    NSArray* content = [NSArray new];
    
    // here will be created content with attachments
    
    return content;
}

- (NSArray*) createCommentsContent
{
    NSArray* content = [NSArray new];
    
    // here will be created content with comments
    
    return content;
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

@end
