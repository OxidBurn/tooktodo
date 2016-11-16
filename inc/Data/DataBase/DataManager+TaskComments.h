//
//  DataManager+TaskComments.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/16/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "ProjectTask+CoreDataClass.h"

@interface DataManager (TaskComments)

// methods
- (void) persistNewCommentsForSelectedTasks: (NSArray*)              commentsList
                             withCompletion: (CompletionWithSuccess) completion;

- (NSArray*) getAllCommentsForSelectedTask;

- (NSArray*) getAllCommentsForTask: (ProjectTask*) task;

@end
