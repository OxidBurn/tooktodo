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
#import "ProjectsEnumerations.h"
#import "ProjectInfo+CoreDataClass.h"

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

- (LogUserInfo*) getUserWithID: (NSNumber*) userId
{
    ProjectTask* task             = [DataManagerShared getSelectedTask];
    __block LogUserInfo* userInfo = nil;
    
    [task.project.projectRoleAssignments enumerateObjectsUsingBlock: ^(ProjectRoleAssignments * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ( [obj.assignee.assigneeID isEqual: userId] )
        {
            userInfo = [[LogUserInfo alloc] initWithName: obj.assignee.displayName
                                          withAvatarPath: obj.assignee.avatarSrc];
            
            *stop = YES;
        }
        else
            if ([obj.invite.inviteID isEqual: userId] )
        {
            userInfo = [[LogUserInfo alloc] initWithName: [obj.invite.firstName stringByAppendingString: obj.invite.lastName]
                                          withAvatarPath: @""];
            
            *stop = YES;
        }
        
    }];
    
    return userInfo;
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
            
            // Parse incoming data and set log type
            [self setupLogType: info.data
                        forLog: logInfo];
        }
        else
        {
            logInfo.logType = @(LogCreatedTaskType);
        }
    }
}

- (void) setupLogType: (TaskLogDataContentModel*) info
               forLog: (TaskLogInfo*)             log
{
    // Add\remove document
    if ( info.storageFiles.count > 0 )
    {
        if ( [log.text containsString: @"приложил"] )
        {
            log.logType = @(LogAddedAttachmentType);
        }
        else
        {
            log.logType = @(LogDeletedAttachmentType);
        }
    }
    
    // Added/remove role role
    if ( info.userId )
    {
        // added
        if ( [log.text containsString: @"добавил"] )
        {
            log.logType = @(LogAddedUserWithRoleType);
        }
        else
        {
            log.logType = @(LogDeletedUserWithRoleType);
        }
    }
    
    // Change task name
    if ( info.oldTitle )
    {
        log.logType = @(LogChangedTaskNameType);
    }
    
    // Added/remove mark
    if ( info.oldValue )
    {
        if ( [log.text containsString: @""] )
        {
            log.logType = @(LogAddedMarkType);
        }
        else
        {
            log.logType = @(LogDeletedMarkType);
        }
    }
    
    // Dates
    if ( [log.text containsString: @"сроки"] )
    {
        if ( [log.text containsString: @"добавил"] )
        {
            log.logType = @(LogAddedDatesType);
        }
        else
            if ( [log.text containsString: @"изменил сроки с"] )
            {
                log.logType = @(LogChangedDatesToNewValueType);
            }
            else
                if ( [log.text containsString: @"изменил"] )
                {
                    log.logType = @(LogChangedDatesType);
                }
                else
                    if ( [log.text containsString: @"удалил"] )
                    {
                        log.logType = @(LogDeletedDatesType);
                    }
    }
    
    // Rooms
    if ( [log.text containsString: @"помещение"] )
    {
        if ( [log.text containsString: @"добавил"] )
        {
            log.logType = @(LogAddedRoomType);
        }
        else
            if ( [log.text containsString: @"изменил"] )
            {
                log.logType = @(LogChangedRoomType);
            }
            else
                if ( [log.text containsString: @"удалил"] )
                {
                    log.logType = @(LogChangedRoomType);
                }
    }
    
    // Changed stages
    if ( info.oldStageId )
    {
        log.logType = @(LogMovedTaskType);
    }
    
    // Changed task type
    if ( info.oldType )
    {
        log.logType = @(LogChangedTypeOfTaskType);
    }
    
    // Add/update/delete comment
    if ( info.commentId )
    {
        log.logType = @(LogAddedCommentType);
    }
    
    // Changed task status type
    if ( info.oldStatus )
    {
        log.logType = @(LogChangedTaskStatusType);
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
    dataContent.oldStatus                = info.oldStatus;
    dataContent.newStatus                = info.statusNew;
    dataContent.projectRoleAssignmentId  = info.projectRoleAssignmentId;
    dataContent.newValue                 = info.valueNew;
    dataContent.oldValue                 = info.oldValue;
    dataContent.oldStartDate             = info.oldStartDate;
    dataContent.newStartDate             = info.startDateNew;
    dataContent.oldDescription           = info.oldDescription;
    dataContent.newDescription           = info.descriptionNew;
    dataContent.storageFiles             = info.storageFiles;
    dataContent.fileTitles               = info.fileTitles;
    dataContent.fileTitlesWithExtensions = info.fileTitlesWithExtensions;
    dataContent.newEndDate               = info.endDateNew;
    dataContent.oldEndDate               = info.oldEndDate;
    dataContent.userId                   = info.userId;
    dataContent.oldTitle                 = info.oldTitle;
    dataContent.titleNew                 = info.titleNew;
    dataContent.oldStageId               = info.oldStageId;
    dataContent.stageIdNew               = info.stageIdNew;
    dataContent.oldRoomId                = info.oldRoomId;
    dataContent.roomIdNew                = info.roomIdNew;
    dataContent.isAllRoomsNew            = info.isAllRoomsNew;
    dataContent.oldIsAllRooms            = info.oldIsAllRooms;
    dataContent.oldType                  = info.oldType;
    dataContent.typeNew                  = info.typeNew;
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
