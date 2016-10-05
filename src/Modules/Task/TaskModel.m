//
//  TaskModel.m
//  TookTODO
//
//  Created by Глеб on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "TaskModel.h"

// Frameworks

// Classes
#import "DataManager+Tasks.h"
#import "TaskRowContent.h"

typedef NS_ENUM(NSUInteger, TaskTableViewCells) {
    
    TaskDetailCell,
    TaskDescriptionCell,
    CollectionCell,
    TaskOptionsCell,
    SubtaskInfoCell,
    
};


@interface TaskModel()

// properties
@property (strong, nonatomic) ProjectTask* task;

@property (strong, nonatomic) NSArray* taskTableViewContent;

@property (strong, nonatomic) NSArray* tableViewCellsIdArray;


// methods


@end

@implementation TaskModel

#pragma mark - Properties -

- (NSArray*) tableViewCellsIdArray
{
    if ( _tableViewCellsIdArray == nil )
    {
        _tableViewCellsIdArray = @[ @"", @"", @"", @"", @"" ];
    }
    
    return _tableViewCellsIdArray;
}

- (ProjectTask*) task
{
    if ( _task == nil )
    {
        _task = [DataManagerShared getSelectedTask];
    }
    
    return _task;
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
    
    rowOne.taskName = self.task.title;
    rowOne.taskStartDate = self.task.startDay;
    rowOne.taskEndDate   = self.task.endDate;
    rowOne.taskStatusDescription = self.task.statusDescription;
    
    return @[ rowOne ];
}

@end
