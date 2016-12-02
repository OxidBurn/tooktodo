//
//  ProjectStageTasksListModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 12/2/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

// Classes

#import "TaskSortedByProjectModel.h"

@interface ProjectStageTasksListModel : JSONModel

@property (strong, nonatomic) NSArray<TaskSortedByProjectModel, Optional>* list;

@property (strong, nonatomic) NSNumber* count;

@property (strong, nonatomic) NSNumber* amount;

@end
