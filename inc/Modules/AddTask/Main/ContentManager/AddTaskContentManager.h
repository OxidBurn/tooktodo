//
//  AddTaskContentManager.h
//  TookTODO
//
//  Created by Nikolay Chaban on 14.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "DataManager+Tasks.h"
#import "RowContent.h"
#import "NewTask.h"

typedef NS_ENUM(NSUInteger, AddTaskScreenSegueId)
{
    ShowAddCommentSegueId,
    ShowTermsSegueID,
    ShowSelectResponsibleControllerSegueID,
    ShowSelectClaimingControllerSegueID,
    ShowSelectObserversControllerSegueID,
    ShowPremisesSegueID,
    ShowSelectStageSegueID,
    ShowSelectSystemSegueID,
    ShowSelectRoomSegueID,
    ShowAddTaskTypeSegueID,
};

typedef NS_ENUM(NSUInteger, AddTaskRowsTypeSectionOne) {
    
    TaskNameRow,
    TaskDescriptionRow,
    TaskHiddenStatusRow,
    TaskResponsibleRow,
    TaskClaimingRow,
    TaskObserversRow
    
};

typedef NS_ENUM(NSUInteger, AddTaskRowsTypeSectionTwo) {
    
    TaskTermsRow,
};

typedef NS_ENUM(NSUInteger, AddTaskRowTypeSectionThree) {
    
    TaskPremisesRow,
    TaskTasksOnPlanRow,
    TaskStageRow,
    TaskSystemRow,
    TaskTypeRow,
    TaskDocumentsRow,
    
};

@interface AddTaskContentManager : NSObject

// properties
@property (strong, nonatomic) NSArray* addTaskContentArray;

@property (strong, nonatomic) NewTask* task;

@property (strong, nonatomic) ProjectTask* projectTask;

@property (strong, nonatomic) NSArray* addTaskTableViewCellsInfo;

@property (strong, nonatomic) NSArray* addTaskTableViewSeguesInfo;

@property (assign, nonatomic) AddTaskControllerType controllerType;

// methods
- (NSArray*) getTableViewContentForControllerType: (AddTaskControllerType) controllerType;

- (NewTask*) getNewTaskObject;

- (void) updateTaskNameWithString: (NSString*) newTaskName;


@end
