//
//  TaskLogsModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface TaskLogsModel : JSONModel

//@property (nonatomic, strong) NSArray <TaskLogContentModel, Optional>* list;
@property (nonatomic, strong) NSNumber*                                unviewedCount;

@end
