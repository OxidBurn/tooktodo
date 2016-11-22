//
//  AddTaskModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ReactiveCocoa.h"

//Classes
#import "NewTask.h"
#import "ProjectsEnumerations.h"
#import "RowContent.h"

@protocol AddTaskModelDelegate;
@protocol AddTaskModelDataSource;

@interface AddTaskModel : NSObject

// properties
@property (weak, nonatomic) id <AddTaskModelDelegate> delegate;
@property (nonatomic, weak) id <AddTaskModelDataSource> dataSource;

// methods

- (NSUInteger) getNumberOfRowsForSection: (NSUInteger) section;

- (NSString*) getSegueIdForIndexPath: (NSIndexPath*) indexPath;

- (void) updateTaskNameWithString: (NSString*) newTaskName;

- (BOOL) isValidTaskName: (NSString*) taskName;

- (NewTask*) returnNewTask;

- (NSArray*) returnAllSeguesArray;

- (NSArray*) returnSelectedResponsibleArray;

- (NSArray*) returnSelectedClaimingArray;

- (NSArray*) returnSelectedObserversArray;

- (TermsData*) returnTerms;

- (ProjectSystem*) returnSelectedSystem;

- (ProjectTaskStage*) returnSelectedStage;

- (id) returnSelectedRoom;

- (TaskType) returnSelectedTaskType;

- (NSString*) returnSelectedTaskTypeDesc;

- (NSString*) returnTaskName;

- (void) storeNewTaskWithCompletion: (CompletionWithSuccess) completion;

- (void) fillDefaultStage: (ProjectTaskStage*) stage
           andHiddenState: (BOOL)              isHidden;

- (void) fillControllerType: (AddTaskControllerType) controllerType;

- (RowContent*) getContentForIndexPath: (NSIndexPath*) indexPath;

- (void) fillTaskToEdit: (ProjectTask*) taskToEdit;


- (BOOL) checkSubtasks;

- (NSString*) returnTaskToEditTitle;

- (void) deselectAllRoomsInfo;

- (void) deleteTaskWithSubtask: (BOOL)                  withSubtask
                withCompletion: (CompletionWithSuccess) completion;


@end

@protocol AddTaskModelDelegate <NSObject>

- (void) reloadData;

@end

@protocol AddTaskModelDataSource <NSObject>

- (AddTaskControllerType) getControllerType;

@end

