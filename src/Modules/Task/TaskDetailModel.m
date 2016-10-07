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

// Factories
#import "TaskDetailInfoFactory.h"
#import "TaskDescriptionFactory.h"
#import "CollectionCellFactory.h"

typedef NS_ENUM(NSUInteger, TaskTableViewCells) {
    
    TaskDetailCell,
    TaskDescriptionCell,
    CollectionCell,
    TaskOptionsCell,
    SubtaskInfoCell,
    
};




@interface TaskDetailModel()

// properties
@property (strong, nonatomic) ProjectTask* task;

@property (strong, nonatomic) NSArray* taskTableViewContent;

@property (strong, nonatomic) NSArray* tableViewCellsIdArray;

@property (strong, nonatomic) NSArray* rowsHeighsArray;


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
        _rowsHeighsArray = @[ @(162), @(117), @(232) ,@(50),  @(50) ];
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
{
    TaskRowContent* row = self.taskTableViewContent[indexPath.section][indexPath.row];
    
    return row.rowHeight;
}

- (UITableViewCell*) createCellForTableView: (UITableView*) tableView
                               forIndexPath: (NSIndexPath*) indexPath
{
    NSArray* section = self.taskTableViewContent[indexPath.section];
    
    TaskRowContent* content = section[indexPath.row];
    
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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
    }
    
    return cell;
}

#pragma mark - Public -

- (void) deselectTask
{
    [DataManagerShared updateSelectedStateForTask: self.task
                                withSelectedState: NO];
}

#pragma mark - Internal -

- (NSArray*) returnTableViewContent
{
    NSArray* sectionOne = [self createSectionOne];
    
    return @[ sectionOne] ;
}

- (NSArray*) createSectionOne
{
    TaskRowContent* rowOne = [TaskRowContent new];
    
    rowOne.cellId        = self.tableViewCellsIdArray[TaskDetailCell];
    rowOne.rowHeight     = [self returnFloatFromNumber: self.rowsHeighsArray[TaskDetailCell]];
    rowOne.taskStartDate = self.task.startDay;
    rowOne.taskEndDate   = self.task.endDate;
    rowOne.isExpired     = self.task.isExpired;
    rowOne.status        = self.task.status.integerValue;
    rowOne.taskTypeDescription = self.task.taskTypeDescription;
    rowOne.workAreaShortTitle  = self.task.workArea.shortTitle;
    rowOne.taskTitle     = self.task.title;
    rowOne.statusDescription = self.task.statusDescription;
    rowOne.subtasksNumber = self.task.subTasks.count;
    rowOne.attachmentsNumber = self.task.attachments.integerValue;
    rowOne.roomNumber       = self.task.room.number.integerValue;
    
    TaskRowContent* rowTwo = [TaskRowContent new];
    
    rowTwo.cellId          = self.tableViewCellsIdArray[TaskDescriptionCell];
    rowTwo.rowHeight       = [self returnFloatFromNumber: self.rowsHeighsArray[TaskDescriptionCell]];
    rowTwo.taskDescription = self.task.taskDescription;
    
    TaskRowContent* rowThree = [TaskRowContent new];
    rowThree.cellId    = self.tableViewCellsIdArray[CollectionCell];
    rowThree.rowHeight = [self returnFloatFromNumber: self.rowsHeighsArray[CollectionCell]];
        
    return @[ rowOne, rowTwo, rowThree ];
}

#pragma mark - Helpers -

- (CGFloat) returnFloatFromNumber: (NSNumber*) number
{
    return number.floatValue;
}

//- (NSUInteger) returnRoomLevenIntValue: (ProjectTaskRoomLevel*) projectTaskRoomLvl
//{
//    
//}

@end
