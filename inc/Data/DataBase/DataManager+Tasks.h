//
//  DataManager+Tasks.h
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "ProjectInfo.h"


@interface DataManager (Tasks)

- (void) persistNewTasks: (NSArray*)              tasks
          withCompletion: (CompletionWithSuccess) completion;

@end
