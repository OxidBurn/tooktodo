//
//  TaskLogContentModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

// Classes
#import "TaskLogContentModel.h"

@interface TaskLogsModel : JSONModel

@property (nonatomic, strong) NSArray <TaskLogContentModel, Optional>* list;
@property (nonatomic, strong) NSNumber*                                unviewedCount;

@end
