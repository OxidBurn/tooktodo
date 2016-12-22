//
//  TaskDetailContentManager.h
//  TookTODO
//
//  Created by Chaban Nikolay on 18.10.16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import <Foundation/Foundation.h>

// Classes
#import "TaskRowContent.h"
#import "DataManager+Tasks.h"
#import "ProjectsEnumerations.h"

@interface TaskDetailContentManager : NSObject

// properties
@property (assign, nonatomic) CGRect tableViewFrame;

// methods
- (NSArray*) getTableViewContentForTask: (ProjectTask*) task
                  forTableViewWithFrame: (CGRect)       tableViewFrame;

- (NSArray*) createSectionTwoContentAccordingToType: (NSUInteger) typeIndex
                                            forTask: (ProjectTask*) task;

- (NSArray*) updateContentWithSortedSubtasks: (NSArray*) sortedArray
                                  forContent: (NSArray*) content;

@end
