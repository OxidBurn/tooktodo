//
//  TaskModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "TaskRowContent.h"
#import "ProjectsEnumerations.h"
#import "ProjectTask+CoreDataClass.h"

@protocol TaskDetailModelDelegate;

@interface TaskDetailModel : NSObject

//Properties

@property (nonatomic, weak) id<TaskDetailModelDelegate> delegate;

// methods
- (NSUInteger) returnNumberOfRowsForIndexPath: (NSInteger) section;

- (NSArray*) returnHeaderNumbersInfo;

- (TaskStatusType) getTaskStatus;

- (void) deselectTask;

- (void) updateSecondSectionContentType: (NSUInteger) typeIndex;

- (void) updateTaskStatus;

- (TaskRowContent*) getContentForIndexPath: (NSIndexPath*) indexPath;

- (TaskInfoSecondSectionContentType) getSecondSectionContentType;

- (NSString*) getTaskTitle;

- (NSString*) getTaskDescriptionValue;

- (void) fillSelectedTask: (ProjectTask*) task
           withCompletion: (CompletionWithSuccess) completion;

- (ProjectTaskStage*) getTaskStage;

- (BOOL) getTaskState;

@end

@protocol TaskDetailModelDelegate <NSObject>

@optional

- (void) reloadData;

- (void) fillCurrentTaskStatus: (TaskStatusType) currentStatus;

@end
