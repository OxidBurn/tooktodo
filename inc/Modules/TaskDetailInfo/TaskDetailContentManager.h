//
//  TaskDetailContentManager.h
//  TookTODO
//
//  Created by Глеб on 18.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "TaskRowContent.h"
#import "DataManager+Tasks.h"
#import "ProjectsEnumerations.h"

@interface TaskDetailContentManager : NSObject

// methods
- (NSArray*) getTableViewContentForTask: (ProjectTask*) task;

- (NSArray*) createSectionTwoContentAccordingToType: (NSUInteger) typeIndex
                                            forTask: (ProjectTask*) task;

@end
