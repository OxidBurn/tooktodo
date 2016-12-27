//
//  AddTaskViewController.h
//  TookTODO
//
//  Created by Nikolay Chaban on 12.09.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ProjectTaskStage+CoreDataClass.h"
#import "ProjectsEnumerations.h"

@protocol AddTaskControllerDelegate;

@interface AddTaskViewController : UIViewController

// properties
@property (weak, nonatomic) id <AddTaskControllerDelegate> delegate;

// methods
- (void) fillDefaultStage: (ProjectTaskStage*) stage
           andHiddenState: (BOOL)              isHidden;

- (void) fillControllerType: (AddTaskControllerType) controllerType
               withDelegate: (id)                    delegate;

- (void) fillTaskToEdit: (ProjectTask*) taskToEdit;

@end

@protocol AddTaskControllerDelegate <NSObject>

@optional

- (void) reloadTaskDetailTableView;

@end
