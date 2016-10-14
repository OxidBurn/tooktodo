//
//  TaskAvailableActionsModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/14/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Frameworks
#import <JSONModel/JSONModel.h>

// Classes
#import "TaskActionModel.h"
#import "TaskStatusActionModel.h"
#import "TaskStagesActionModel.h"

@interface TaskAvailableActionsModel : JSONModel

@property (strong, nonatomic) NSArray<TaskActionModel>* actions;

@property (strong, nonatomic) NSArray<TaskStatusActionModel>* statusActions;

@property (strong, nonatomic) NSArray<TaskStagesActionModel>* stages;

@end
