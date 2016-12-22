//
//  TaskViewController.h
//  TookTODO
//
//  Created by Chaban Nikolay on 05.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <UIKit/UIKit.h>
//Classes
#import "ProjectsEnumerations.h"
#import "ProjectTask+CoreDataClass.h"
#import "BaseMainViewController.h"

@protocol TaskDetailViewControllerDelegate;

@interface TaskDetailViewController : BaseMainViewController

@property (nonatomic, weak) id <TaskDetailViewControllerDelegate> delegate;

// methods

- (TaskStatusType) getStatusType;

- (void) fillSelectedTask: (ProjectTask*) task;

- (void) refreshTableView;

@end

@protocol TaskDetailViewControllerDelegate <NSObject>

- (void) fillSelectedTask: (ProjectTask*) selectedTask;

- (void) addNotifications;

@end
