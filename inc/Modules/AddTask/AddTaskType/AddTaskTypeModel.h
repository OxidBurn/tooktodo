//
//  AddTaskTypeModel.h
//  TookTODO
//
//  Created by Nikolay Chaban on 10/7/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

// Classes
#import "ProjectsEnumerations.h"

@interface AddTaskTypeModel : NSObject

// methods
- (UIColor*) getTaskTypeColor: (TaskType) type;

- (NSString*) getTaskTypeDescription: (TaskType) type;

@end
