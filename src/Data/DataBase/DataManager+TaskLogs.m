//
//  DataManager+TaskLogs.m
//  TookTODO
//
//  Created by Nikolay Chaban on 11/23/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+TaskLogs.h"

// Classes
#import "TaskLogInfo+CoreDataClass.h"
#import "TaskLogDataContent+CoreDataClass.h"
#import "TaskLogContentModel.h"
#import "TaskLogDataContentModel.h"

@implementation DataManager (TaskLogs)

- (void) persistNewLogs: (NSArray*)              logsInfo
                forTask: (ProjectTask*)          task
         withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        [logsInfo enumerateObjectsUsingBlock:^(TaskLogContentModel* log, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [self persistNewLog: log
                        forTask: task
                      inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}


#pragma mark - Internal methods -


- (void) persistNewLog: (TaskLogContentModel*)          info
               forTask: (ProjectTask*)            task
             inContext: (NSManagedObjectContext*) context
{
    TaskLogInfo* logInfo = [self getTaskLogWithInfo: info
                                          inContext: context];
    
    if ( logInfo == nil )
    {
        logInfo = [TaskLogInfo MR_createEntityInContext: context];
        
        logInfo.task = task;
        
        if ( info.data )
        {
            [self persistNewLogsData: info.data
                              forLog: logInfo
                           inContext: context];
        }
    }
}

- (void) persistNewLogsData: (TaskLogDataContentModel*) info
                     forLog: (TaskLogInfo*)            log
                  inContext: (NSManagedObjectContext*) context
{
    TaskLogDataContent* dataContent = [TaskLogDataContent MR_createEntityInContext: context];
    
    dataContent.taskLog = log;
}

- (TaskLogInfo*) getTaskLogWithInfo: (TaskLogContentModel*)    info
                          inContext: (NSManagedObjectContext*) context
{
    NSPredicate* findPredicate = [NSPredicate predicateWithFormat: @"createdDate == %@ AND userFullName == %@", info.createdDate, info.userFullName];
    
    TaskLogInfo* log = [TaskLogInfo MR_findFirstWithPredicate: findPredicate
                                                    inContext: context];
    
    return log;
}

@end
