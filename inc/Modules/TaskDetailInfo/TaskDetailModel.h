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


// methods for different counts
- (NSUInteger) returnNumberOfRowsForIndexPath: (NSInteger) section;

- (CGFloat) countHeightForCommentCellForIndexPath: (NSIndexPath*) indexPath;

- (NSString*) getTaskTitle;

- (NSString*) getTaskDescriptionValue;


// getters for table view
- (NSArray*) returnHeaderNumbersInfo;

- (TaskRowContent*) getContentForIndexPath: (NSIndexPath*) indexPath;

- (TaskInfoSecondSectionContentType) getSecondSectionContentType;

- (TaskStatusType) getTaskStatus;


// methods for work with content or data base
- (void) deselectTask;

- (void) updateSecondSectionContentType: (NSUInteger) typeIndex;

- (void) updateTaskStatus;

- (void) fillSelectedTask: (ProjectTask*) task
           withCompletion: (CompletionWithSuccess) completion;

- (void) createContentForTableViewWithFrame: (CGRect) frame;


// methods for handling controller type
- (ProjectTaskStage*) getTaskStage;

- (BOOL) getTaskState;

@end


@protocol TaskDetailModelDelegate <NSObject>

@optional

- (void) reloadData;

- (void) fillCurrentTaskStatus: (TaskStatusType) currentStatus;

@end
