//
//  DataManager+Tasks.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+Tasks.h"

// Classes
#import "ProjectInfo+CoreDataClass.h"
#import "ProjectTaskRoom+CoreDataClass.h"
#import "ProjectTaskOwner.h"
#import "ProjectTaskStage+CoreDataClass.h"
#import "ProjectTaskMarker.h"
#import "ProjectTaskAssignee+CoreDataClass.h"
#import "ProjectTaskRoleType.h"
#import "ProjectTaskSubTasks.h"
#import "ProjectTaskWorkArea.h"
#import "ProjectTaskRoomLevel.h"
#import "ProjectTaskMapContour.h"
#import "ProjectTaskResponsible+CoreDataClass.h"
#import "ProjectTaskRoleAssignment.h"
#import "ProjectTaskRoleAssignments.h"
#import "ProjectTaskModel.h"
#import "TaskRoomModel.h"
#import "TaskOwnerModel.h"
#import "TaskStageModel.h"
#import "TaskMarkerModel.h"
#import "TaskAssigneeModel.h"
#import "TaskSubTasksModel.h"
#import "TaskWorkAreaModel.h"
#import "TaskRoomLevelModel.h"
#import "TaskMapContourModel.h"
#import "TaskMarkerComponent.h"
#import "TaskResponsibleModel.h"
#import "TaskApprovementsModel.h"
#import "TaskProjectRoleTypeModel.h"
#import "TaskProjectRoleAssignmentModel.h"
#import "TaskRoleAssignmentsModel.h"
#import "TasksGroupedByProjects.h"
#import "ProjectInviteInfo+CoreDataClass.h"
#import "ProjectRoleType+CoreDataClass.h"

// Categories
#import "DataManager+ProjectInfo.h"

@implementation DataManager (Tasks)


#pragma mark - Public methods -

- (void) persistTasks: (NSArray*)              tasks
       withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        // Get selected project info
        // For storing
        ProjectInfo* project = [DataManagerShared getSelectedProjectInfoInContext: localContext];
        
        [tasks enumerateObjectsUsingBlock: ^(ProjectTaskModel* taskModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistTaskWithInfo: taskModel
                           forProject: project
                            inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (void) persistTasksForProjects: (TasksGroupedByProjects*) info
                  withCompletion: (CompletionWithSuccess)   completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        [info.projects enumerateObjectsUsingBlock: ^(ShortProjectInfoModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ProjectInfo* project = [DataManagerShared getProjectWithID: @(obj.projectID)
                                                              inCotext: localContext];
            
            [obj.tasks enumerateObjectsUsingBlock: ^(ProjectTaskModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                [self persistTaskWithInfo: obj
                               forProject: project
                                inContext: localContext];
                
            }];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                         
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}


#pragma mark - Internal methods -

- (void) persistTaskWithInfo: (ProjectTaskModel*)       info
                  forProject: (ProjectInfo*)            project
                   inContext: (NSManagedObjectContext*) context
{
    ProjectTask* task = [ProjectTask MR_findFirstOrCreateByAttribute: @"taskID"
                                                           withValue: info.taskID
                                                           inContext: context];
    
    if ( info.taskID )
        task.taskID = info.taskID;
    
    if ( info.closedDate )
        task.closedDate = info.closedDate;
    
    if ( info.taskDescription )
        task.descriptionValue = info.taskDescription;
    
    if ( info.duration )
        task.duration = info.duration;
    
    if ( info.endDate )
        task.endDate = info.endDate;
    
    if ( info.extraId )
        task.extraId = info.extraId;
    
    if ( info.isAllRooms )
        task.isAllRooms = info.isAllRooms;
    
    if ( info.isExpired )
        task.isExpired = info.isExpired;
    
    if ( info.isIncludedRestDays )
        task.isIncludedRestDays = info.isIncludedRestDays;
    
    if ( info.isTaskStatusChanged )
        task.isTaskStatusChanged = info.isTaskStatusChanged;
    
    if ( info.isUrgent )
        task.isUrgent = info.isUrgent;
    
    if ( info.mapPreviewImage )
        task.mapPreviewImage = info.mapPreviewImage;
    
    if ( info.ownerUserId )
        task.ownerUserId = info.ownerUserId;
    
    if ( info.parentTaskId )
        task.parentTaskId = info.parentTaskId;
    
    if ( info.projectId )
        task.projectId = info.projectId;
    
    if ( info.projectRelatedId )
        task.projectRelatedId = info.projectRelatedId;
    
    if ( info.status )
        task.status = info.status;
    
    if ( info.statusDescription )
        task.statusDescription = info.statusDescription;
    
    if ( info.storageDirectoryId )
        task.storageDirectoryId = info.storageDirectoryId;
    
    if ( info.storageFilesCount )
        task.storageFilesCount = info.storageFilesCount;
    
    if ( info.taskAccess )
        task.taskAccess = info.taskAccess;
    
    if ( info.taskType )
        task.taskType = info.taskType;
    
    if ( info.taskTypeDescription )
        task.taskTypeDescription = info.taskTypeDescription;
    
    if ( info.title )
        task.title = info.title;
    
    if ( project )
        task.project = project;
    
    if ( info.startDate )
        task.startDay = info.startDate;
    
    if ( info.access )
        task.access = info.access;
    
    if ( info.attachments.count )
        task.attachments = info.attachments.count;
    
    // Store task responsible
    if ( info.responsible )
    {
        [self persistTaskResponsible: info.responsible
                             forTask: task
                           inContext: context];
    }
    
    // Store task stage
    if ( info.stage )
    {
        [self persistTaskStage: info.stage
                       forTask: task
                     inProject: project
                     inContext: context];
    }
    
    // Store task work area
    if ( info.workArea )
    {
        [self persistTaskWorkArea: info.workArea
                          forTask: task
                        inContext: context];
    }
    
    // Store task owner user info
    if ( info.ownerUser )
    {
        [self persistTaskOwnerUser: info.ownerUser
                           forTask: task
                         inContext: context];
    }
    
    // Store task marker info
    if ( info.marker )
    {
        [self persistTaskMarker: info.marker
                        forTask: task
                      inContext: context];
    }
    
    // Store task rool level
    if ( info.roomLevel )
    {
        [self persistTaskRoomLevel: info.roomLevel
                           forTask: task
                         inContext: context];
    }
    
    // Store room value
    if ( info.room )
    {
        [self persistTaskRoom: info.room
                      forTask: task
                 isSingleRoom: YES
                    inContext: context];
    }
    
    // Store task rooms
    if ( info.rooms )
    {
        [info.rooms enumerateObjectsUsingBlock: ^(TaskRoomModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistTaskRoom: obj
                          forTask: task
                     isSingleRoom: NO
                        inContext: context];
            
        }];
    }
    
    // Store subtasks
    if ( info.subTasks )
    {
        [info.subTasks.list enumerateObjectsUsingBlock: ^(ProjectTaskModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistTaskWithInfo: obj
                           forProject: project
                            inContext: context];
            
        }];
    }
    
    // Store tasks role assignments
    if ( info.responsible )
    {
        [info.taskRoleAssignments enumerateObjectsUsingBlock: ^(TaskRoleAssignmentsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
           
            [self persistTaskRoleAssignments: obj
                                     forTask: task
                                   inContext: context];
            
        }];
    }
    
}

- (void) persistTaskResponsible: (TaskResponsibleModel*)   info
                        forTask: (ProjectTask*)            task
                      inContext: (NSManagedObjectContext*) context
{
    ProjectTaskResponsible* responsible = [ProjectTaskResponsible MR_findFirstOrCreateByAttribute: @"responsibleID"
                                                                                        withValue: info.responsibleID
                                                                                        inContext: context];
    
    if ( info.responsibleID )
    {
        responsible.responsibleID = info.responsibleID;
    }
    
    if ( info.isBlocked )
    {
        responsible.isBlocked = info.isBlocked;
    }
    
    if ( info.projectPermission )
    {
        responsible.projectPermission = info.projectPermission;
    }
    
    if ( info.firstName )
    {
        responsible.firstName = info.firstName;
    }
    
    if ( info.lastName )
    {
        responsible.lastName = info.lastName;
    }
    
    if ( info.displayName )
    {
        responsible.displayName = info.displayName;
    }
    
    if ( info.avatarSrc )
    {
        responsible.avatarSrc = info.avatarSrc;
    }
    
    if ( info.isActiveUser )
    {
        responsible.isActiveUser = info.isActiveUser;
    }
    
    responsible.task = task;
    
    // Store responsible assignee
    if ( info.assignee )
    {
        [self persistAssignee: info.assignee
               forResponsible: responsible
                    inContext: context];
    }
    
    // Store responsible
    if ( info.invite )
    {
        [self persistTaskInviteInfo: info.invite
                 forTaskResponsible: responsible
                          inContext: context];
    }
}

- (void) persistAssignee: (TaskAssigneeModel*)      info
          forResponsible: (ProjectTaskResponsible*) responsbile
               inContext: (NSManagedObjectContext*) context
{
    ProjectTaskAssignee* assignee = [ProjectTaskAssignee MR_findFirstOrCreateByAttribute: @"assigneeID"
                                                                               withValue: @(info.assigneeID)
                                                                               inContext: context];
    
    assignee.responsible                      = responsbile;
    assignee.additionalPhoneNumber            = info.additionalPhoneNumber;
    assignee.avatarSrc                        = info.avatarSrc;
    assignee.displayName                      = info.displayName;
    assignee.email                            = info.email;
    assignee.emailConfirmed                   = info.emailConfirmed;
    assignee.firstName                        = info.firstName;
    assignee.assigneeID                       = @(info.assigneeID);
    assignee.isSubscribedOnEmailNotifications = info.isSubscribedOnEmailNotifications;
    assignee.isTourViewed                     = info.isTourViewed;
    assignee.lastName                         = info.lastName;
    assignee.phoneNumber                      = info.phoneNumber;
    assignee.userName                         = info.userName;
}

- (void) persistTaskInviteInfo: (ProjectInviteInfoModel*) info
            forTaskResponsible: (ProjectTaskResponsible*) responsbile
                     inContext: (NSManagedObjectContext*) context
{
    ProjectInviteInfo* invite = [ProjectInviteInfo MR_findFirstOrCreateByAttribute: @"inviteID"
                                                                         withValue: info.inviteID
                                                                         inContext: context];
    
    invite.inviteID               = info.inviteID;
    invite.email                  = info.email;
    invite.firstName              = info.firstName;
    invite.lastName               = info.lastName;
    invite.isUsed                 = info.isUsed;
    invite.isCanceled             = info.isCanceled;
    invite.inviteStatus           = info.inviteStatus;
    invite.message                = info.message;
    invite.projectId              = info.projectId;
    invite.projectName            = info.projectName;
    invite.projectTaskResponsible = responsbile;
    
    [self persistProjectRoleType: info.projectRoleType
                forProjectInvite: invite
                       inContext: context];
}

- (void) persistProjectRoleType: (ProjectRoleTypeModel*)   info
               forProjectInvite: (ProjectInviteInfo*)      invite
                      inContext: (NSManagedObjectContext*) context
{
    ProjectRoleType* roleType = [ProjectRoleType MR_findFirstOrCreateByAttribute: @"roleTypeID"
                                                                       withValue: info.roleTypeID
                                                                       inContext: context];
    
    roleType.projectInvite = invite;
    roleType.title         = info.title;
    roleType.roleTypeID    = info.roleTypeID;
}

- (void) persistRoleAssignment: (TaskProjectRoleAssignmentModel*) info
                   forAssignee: (ProjectTaskAssignee*)            assignee
                     inContext: (NSManagedObjectContext*)         context
{
    
}

- (void) persistTaskStage: (TaskStageModel*)         info
                  forTask: (ProjectTask*)            task
                inProject: (ProjectInfo*)            project
                inContext: (NSManagedObjectContext*) context
{
    ProjectTaskStage* stage = [ProjectTaskStage MR_findFirstOrCreateByAttribute: @"stageID"
                                                                      withValue: @(info.stageID)
                                                                      inContext: context];
    
    stage.stageID  = @(info.stageID);
    stage.isCommon = @(info.isCommon);
    stage.title    = info.title;
    stage.project  = project;
    
    [stage addTasksObject: task];
}

- (void) persistTaskWorkArea: (TaskWorkAreaModel*)      info
                     forTask: (ProjectTask*)            task
                   inContext: (NSManagedObjectContext*) context
{
    ProjectTaskWorkArea* workArea = [ProjectTaskWorkArea MR_findFirstOrCreateByAttribute: @"workAreaID"
                                                                               withValue: @(info.workAreaID
                                     ) inContext: context];
    
    workArea.task       = task;
    workArea.workAreaID = @(info.workAreaID);
    workArea.title      = info.title;
    workArea.shortTitle = info.shortTitle;
}

- (void) persistTaskOwnerUser: (TaskOwnerModel*)         info
                      forTask: (ProjectTask*)            task
                    inContext: (NSManagedObjectContext*) context
{
    ProjectTaskOwner* ownerUser = [ProjectTaskOwner MR_findFirstOrCreateByAttribute: @"ownerID"
                                                                          withValue: @(info.ownerID
                                   ) inContext: context];
    
    ownerUser.task                             = task;
    ownerUser.ownerID                          = @(info.ownerID);
    ownerUser.additionalPhoneNumber            = info.additionalPhoneNumber;
    ownerUser.avatarSrc                        = info.avatarSrc;
    ownerUser.displayName                      = info.displayName;
    ownerUser.email                            = info.email;
    ownerUser.emailConfirmed                   = @(info.emailConfirmed);
    ownerUser.firstName                        = info.firstName;
    ownerUser.isSubscribedOnEmailNotifications = @(info.isSubscribedOnEmailNotifications);
    ownerUser.isTourViewed                     = @(info.isTourViewed);
    ownerUser.lastName                         = info.lastName;
    ownerUser.phoneNumber                      = info.phoneNumber;
    ownerUser.userName                         = info.userName;
}

- (void) persistTaskMarker: (TaskMarkerModel*)        info
                   forTask: (ProjectTask*)            task
                 inContext: (NSManagedObjectContext*) context
{
    ProjectTaskMarker* marker = [ProjectTaskMarker MR_findFirstOrCreateByAttribute: @"markerID"
                                                                         withValue: @(info.markerID)
                                                                         inContext: context];
    
    marker.task        = task;
    marker.markerID    = @(info.markerID);
    marker.x           = @(info.x);
    marker.y           = @(info.y);
    marker.roomLevelId = @(info.roomLevelId);
    marker.mapId       = @(info.mapId);
}

- (void) persistTaskRoomLevel: (TaskRoomLevelModel*)     info
                      forTask: (ProjectTask*)            task
                    inContext: (NSManagedObjectContext*) context
{
    ProjectTaskRoomLevel* roomLevel = [ProjectTaskRoomLevel MR_findFirstOrCreateByAttribute: @"roomLevel"
                                                                                  withValue: @(info.roomLevelID)
                                                                                  inContext: context];
    
    roomLevel.task      = task;
    roomLevel.roomLevel = @(info.roomLevelID);
    roomLevel.level     = @(info.level);
}

- (void) persistTaskRoom: (TaskRoomModel*)          info
                 forTask: (ProjectTask*)            task
            isSingleRoom: (BOOL)                    isSingle
               inContext: (NSManagedObjectContext*) context
{
    ProjectTaskRoom* room = [ProjectTaskRoom MR_findFirstOrCreateByAttribute: @"roomID"
                                                                   withValue: @(info.roomID)
                                                                   inContext: context];
    
    room.task   = task;
    room.roomID = @(info.roomID);
    room.number = info.number;
    room.title  = info.title;
    
    if ( isSingle == NO )
    {
        room.roomLevelId         = info.roomLevelId;
        room.tasksCount          = info.tasksCount;
        room.tasksWithoutMarkers = info.tasksWithoutMarkers;
    }
    
    [self persistMapContour: info.mapContour
                    forRoom: room
                  inContext: context];
}

- (void) persistMapContour: (TaskMapContourModel*)    info
                   forRoom: (ProjectTaskRoom*)        room
                 inContext: (NSManagedObjectContext*) context
{
    ProjectTaskMapContour* mapContour = [ProjectTaskMapContour MR_findFirstOrCreateByAttribute: @"mapContourID"
                                                                                     withValue: @(info.mapContourID)
                                                                                     inContext: context];
    
    mapContour.room         = room;
    mapContour.geoJson      = info.geoJson;
    mapContour.mapContourID = @(info.mapContourID);
    mapContour.previewImage = info.previewImage;
    mapContour.roomId       = @(info.roomId);
}

- (void) persistTaskRoleAssignments: (TaskRoleAssignmentsModel*) info
                            forTask: (ProjectTask*)              task
                          inContext: (NSManagedObjectContext*)   context
{
    ProjectTaskRoleAssignments* roleAssignments = [ProjectTaskRoleAssignments MR_findFirstOrCreateByAttribute: @"roleAssignmentsID"
                                                                                                    withValue: @(info.roleAssignmentsID)
                                                                                                    inContext: context];
    
    roleAssignments.task                    = task;
    roleAssignments.roleAssignmentsID       = @(info.roleAssignmentsID);
    roleAssignments.taskRoleType            = @(info.taskRoleType);
    roleAssignments.taskRoleTypeDescription = info.taskRoleTypeDescription;
}

- (void) updateExpandedStateOfStage: (ProjectTaskStage*)     stageInfo
                     withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        stageInfo.isExpanded = @(!stageInfo.isExpanded.boolValue);
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                         
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (ProjectRoleAssignments*) getSelectedProjectRoleAssignment
{
    ProjectRoleAssignments* assignment = [ProjectRoleAssignments MR_findFirstByAttribute: @"isSelected"
                                                                               withValue: @(YES)];
    
    return assignment;
}

- (void) changeItemSelectedState: (BOOL)                    isSelected
                         forItem: (ProjectRoleAssignments*) assignment
{
    ProjectRoleAssignments* selectedRoleAssignment = [self getSelectedProjectRoleAssignment];
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        
        selectedRoleAssignment.isSelected = @(NO);
        assignment.isSelected             = @(YES);
        
    }
                      completion:^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          NSLog(@"Selected %@", [self getSelectedProjectRoleAssignment]);
                          
                      }];
}


- (NSArray*) getStagesForCurrentProject
{
    ProjectInfo* currentProject = [DataManagerShared getSelectedProjectInfo];
    
    NSArray* stages = currentProject.stage.allObjects;
    
    return stages;
}


@end
