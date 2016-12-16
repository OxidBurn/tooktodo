//
//  TaskViewModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Frameworks
@import UIKit;

//Classes
#import "ProjectsEnumerations.h"
#import "ProjectTask+CoreDataClass.h"
#import "ProjectTaskStage+CoreDataClass.h"
#import "PopoverViewController.h"
#import "PopoverModel.h"

@class TaskDetailModel;

@interface TaskDetailViewModel : NSObject <UITableViewDelegate, UITableViewDataSource,  PopoverModelDelegate, PopoverModelDataSource>

// properties
@property (nonatomic, copy) void(^reloadTableView)();

@property (nonatomic, copy) void(^performSegue)(NSString* segueID);

@property (nonatomic, copy) void(^presentControllerAsPopover)(CGRect frame);

@property (nonatomic, copy) void(^showSortingPopoverBlock)(CGRect frame);

@property (nonatomic, copy) void(^initSubtaskDetailInfoController)();

@property (nonatomic, assign) CGFloat keyboardHeight;

@property (strong, nonatomic) TaskDetailModel* model;

// methods
- (void) deselectTaskWithCompletion: (CompletionWithSuccess) completion;

- (void) updateSecondSectionContentForType: (NSUInteger) typeIndex;

- (TaskStatusType) getTaskStatus;

- (void) updateTaskStatus;

- (void) hideKeyboard;

- (void) scrollToCommentCell;

- (void) showCommentCell;

- (void) fillSelectedTask: (ProjectTask*)          task
           withCompletion: (CompletionWithSuccess) completion;

- (NSString*) getTaskNumberTitle;

- (NSString*) getProjectTitle;

- (ProjectTask*) getSelectedSubtask;

// Reloading task content info, after appearing on task info screen
- (void) reloadDataWithCompletion: (CompletionWithSuccess) completion;

- (ProjectTaskStage*) getTaskStage;

- (BOOL) getTaskState;

- (ProjectTask*) getCurrentTask;

@end
