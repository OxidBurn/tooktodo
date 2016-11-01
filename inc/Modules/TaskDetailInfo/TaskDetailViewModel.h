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

@interface TaskDetailViewModel : NSObject <UITableViewDelegate, UITableViewDataSource>

// properties
@property (nonatomic, copy) void(^reloadTableView)();

@property (nonatomic, copy) void(^performSegue)(NSString* segueID);

// methods
- (void) deselectTask;

- (void) updateSecondSectionContentForType: (NSUInteger) typeIndex;

- (TaskStatusType) getTaskStatus;

- (void) updateTaskStatus;

- (void) fillSelectedTask: (ProjectTask*)          task
           withCompletion: (CompletionWithSuccess) completion;


@end
