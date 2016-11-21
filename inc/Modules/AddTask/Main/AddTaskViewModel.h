//
//  AddTaskViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 16.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

//Frameworks
@import UIKit;
#import "ReactiveCocoa/ReactiveCocoa.h"

//Classes
#import "NewTask.h"
#import "AddTaskModel.h"
#import "OSAlertController.h"
#import "OSAlertDeleteTaskWithSubtasksController.h"
#import "DataManager+Room.h"

@protocol AddTaskViewModelDelegate;

@interface AddTaskViewModel : NSObject <UITableViewDelegate, UITableViewDataSource, OSAlertDeleteTasksControllerDelegate, OSAlertDeleteTaskWithSubtasksControllerDelegate>

// properties
@property (nonatomic, strong) NSString* taskNameText;
@property (weak, nonatomic) id <AddTaskViewModelDelegate> delegate;

@property (nonatomic, copy) void(^reloadTableView)();
@property (nonatomic, copy) void(^dismissTaskInfo)();

@property (strong, nonatomic) RACCommand* enableAllButtonsCommand;
@property (nonatomic, strong) RACCommand* enableCreteOnBaseBtnCommand;
@property (nonatomic, strong) RACCommand* deleteTaskCommand;
@property (strong, nonatomic) RACSignal*  enableConfirmButtons;


//methods

- (NewTask*) getNewTask;

- (void) storeNewTaskWithCompletion: (CompletionWithSuccess) completion;

- (NSArray*) returnAllSeguesArray;

- (id) returnModel;

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

- (void) fillDefaultStage: (ProjectTaskStage*) stage
           andHiddenState: (BOOL)              isHidden;

- (AddTaskModel*) getModel;

- (void) fillControllerType: (AddTaskControllerType) controllerType;

- (void) fillTaskToEdit: (ProjectTask*) taskToEdit;


- (BOOL) checkSubtasks;

- (NSString*) returnTaskToEditTitle;

- (void) deselectAllRoomsInfo;

@end


@protocol AddTaskViewModelDelegate <NSObject>

- (void) performSegueWithSegueId: (NSString*) segueId;

- (void) reloadAddTaskTableView;

@end
