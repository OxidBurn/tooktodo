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

@protocol AddTaskModelDelegate;

@interface AddTaskModel : NSObject

// properties
@property (weak, nonatomic) id <AddTaskModelDelegate> delegate;
// methods

- (NSUInteger) getNumberOfRowsForSection: (NSUInteger) section;

- (UITableViewCell*) createCellForTableView: (UITableView*) tableView
                               forIndexPath: (NSIndexPath*) indexPath;

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

@end

@protocol AddTaskModelDelegate <NSObject>

- (void) reloadData;

@end
