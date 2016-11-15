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

@protocol AddTaskViewModelDelegate;

@interface AddTaskViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties

@property (nonatomic, copy) void(^reloadTableView)();

@property (weak, nonatomic) id <AddTaskViewModelDelegate> delegate;
@property (strong, nonatomic) RACCommand* enableAllButtonsCommand;
@property (nonatomic, strong) RACCommand* enableCreteOnBaseBtnCommand;
@property (nonatomic, strong) RACCommand* deleteTaskCommand;
@property (strong, nonatomic) RACSignal*  enableConfirmButtons;
@property (nonatomic, strong) NSString* taskNameText;

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

// refactor methods
- (void) fillContentManagerWithContent;

@end

@protocol AddTaskViewModelDelegate <NSObject>

- (void) performSegueWithSegueId: (NSString*) segueId;

- (void) reloadAddTaskTableView;

@end
