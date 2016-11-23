//
//  DataManager+TaskLogs.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"

// Classes
#import "ProjectTask+CoreDataClass.h"

@interface DataManager (TaskLogs)

- (void) persistNewLogs: (NSArray*)              logsInfo
                forTask: (ProjectTask*)          task
         withCompletion: (CompletionWithSuccess) completion;

@end
