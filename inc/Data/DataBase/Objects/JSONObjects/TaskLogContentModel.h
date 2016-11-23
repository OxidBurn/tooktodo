//
//  TaskLogContentModel.h
//  TookTODO
//
//  Created by Chaban Nikolay on 11/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

#import "TaskLogsModel.h"

@interface TaskLogContentModel : JSONModel

@property (nonatomic, strong) TaskLogsModel<Optional>* list;
@property (nonatomic, strong) NSNumber*                unviewedCount;

@end
