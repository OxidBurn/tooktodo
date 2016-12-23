//
//  DataManager+TaskLogs.h
//  TookTODO
//
//  Created by Nikolay Chaban on 11/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager.h"
#import "LogUserInfo.h"

@interface DataManager (TaskLogs)

- (void) persistNewLogs: (NSArray*)              logsInfo
         withCompletion: (CompletionWithSuccess) completion;

- (LogUserInfo*) getUserWithID: (NSNumber*) userId;

@end
