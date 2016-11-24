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
#import "ProjectTask+CoreDataClass.h"

// Categories
#import "DataManager+Tasks.h"

@implementation DataManager (TaskLogs)

- (void) persistNewLogs: (NSArray*)              logsInfo
         withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectTask* selectedTask = [DataManagerShared getSelectedTaskInContext: localContext];
        
        [logsInfo enumerateObjectsUsingBlock:^(TaskLogContentModel* log, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [self persistNewLog: log
                        forTask: selectedTask
                      inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}


#pragma mark - Internal methods -


- (void) persistNewLog: (TaskLogContentModel*)    info
               forTask: (ProjectTask*)            task
             inContext: (NSManagedObjectContext*) context
{
    TaskLogInfo* logInfo = [self getTaskLogWithInfo: info
                                          inContext: context];
    
    if ( logInfo == nil )
    {
        logInfo = [TaskLogInfo MR_createEntityInContext: context];
        
        logInfo.createdDate                = info.createdDate;
        logInfo.projectRoleTypeDescription = info.projectRoleTypeDescription;
        logInfo.text                       = info.text;
        logInfo.userAvatar                 = info.userAvatar;
        logInfo.userFullName               = info.userFullName;
        
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
    
    dataContent.taskRoleType             = info.taskRoleType;
    dataContent.newWorkArea              = info.WorkAreaNew;
    dataContent.oldWorkArea              = info.oldWorkArea;
    dataContent.commentId                = info.commentId;
    dataContent.storageFiles             = info.storageFiles;
    dataContent.oldStatus                = info.oldStatus;
    dataContent.newStatus                = info.statusNew;
    dataContent.projectRoleAssignmentId  = info.projectRoleAssignmentId;
    dataContent.newValue                 = info.valueNew;
    dataContent.oldValue                 = info.oldValue;
    dataContent.oldStartDate             = info.oldStartDate;
    dataContent.newStartDate             = info.startDateNew;
    dataContent.oldDescription           = info.oldDescription;
    dataContent.newDescription           = info.descriptionNew;
    dataContent.fileTitles               = info.fileTitles;
    dataContent.fileTitlesWithExtensions = info.fileTitlesWithExtensions;
    dataContent.newEndDate               = info.endDateNew;
    dataContent.oldEndDate               = info.oldEndDate;
    dataContent.userId                   = info.userId;
    
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
