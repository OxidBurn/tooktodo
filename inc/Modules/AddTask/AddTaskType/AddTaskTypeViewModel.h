//
//  AddTaskTypeViewModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
@import UIKit;

// Classes
#import "ProjectsEnumerations.h"



typedef void(^GetTaskTypeInfoBlock)(NSString* taskTypeDescription, TaskType type);

@interface AddTaskTypeViewModel : NSObject <UITableViewDataSource, UITableViewDelegate>

// methods

- (void) fillSavedTaskType: (TaskType) type;

- (void) getSelectedInfo: (GetTaskTypeInfoBlock) completion;

@end
