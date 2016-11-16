//
//  AddTaskContentManager+ProjectTask.h
//  TookTODO
//
//  Created by Nikolay Chaban on 16.11.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "AddTaskContentManager.h"

@interface AddTaskContentManager (ProjectTask)

// methods
- (NSArray*) convertProjectTaskToContent: (ProjectTask*) task;

@end
