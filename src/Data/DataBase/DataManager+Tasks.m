//
//  DataManager+Tasks.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/9/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+Tasks.h"

// Classes
#import "ProjectInfo.h"
#import "ProjectTaskRoom.h"
#import "ProjectTaskOwner.h"
#import "ProjectTaskStage.h"
#import "ProjectTaskMarker.h"
#import "ProjectTaskAssignee.h"
#import "ProjectTaskRoleType.h"
#import "ProjectTaskSubTasks.h"
#import "ProjectTaskWorkArea.h"
#import "ProjectTaskRoomLevel.h"
#import "ProjectTaskMapContour.h"
#import "ProjectTaskResponsible.h"
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
                                                           withValue: @(info.taskID)
                                                           inContext: context];
    
    task.taskID              = @(info.taskID);
    task.closedDate          = info.closedDate;
    task.descriptionValue    = info.taskDescription;
    task.duration            = info.duration;
    task.endDate             = info.endDate;
    task.extraId             = info.extraId;
    task.isAllRooms          = info.isAllRooms;
    task.isExpired           = @(info.isExpired);
    task.isIncludedRestDays  = @(info.isIncludedRestDays);
    task.isTaskStatusChanged = info.isTaskStatusChanged;
    task.isUrgent            = @(info.isUrgent);
    task.mapPreviewImage     = info.mapPreviewImage;
    task.ownerUserId         = info.ownerUserId;
    task.parentTaskId        = info.parentTaskId;
    task.projectId           = @(info.projectId);
    task.projectRelatedId    = info.projectRelatedId;
    task.status              = @(info.status);
    task.statusDescription   = info.statusDescription;
    task.storageDirectoryId  = info.storageDirectoryId;
    task.storageFilesCount   = info.storageFilesCount;
    task.taskAccess          = info.taskAccess;
    task.taskType            = info.taskType;
    task.taskTypeDescription = info.taskTypeDescription;
    task.title               = info.title;
    task.project             = project;
    
    // Store task responsible
    [self persistTaskResponsible: info.responsible
                         forTask: task
                       inContext: context];
    
    // Store task stage
    [self persistTaskStage: info.stage
                   forTask: task
                 inProject: project
                 inContext: context];
    
    // Store task work area
    [self persistTaskWorkArea: info.workArea
                      forTask: task
                    inContext: context];
    
    // Store task owner user info
    [self persistTaskOwnerUser: info.ownerUser
                       forTask: task
                     inContext: context];
    
    // Store task marker info
    [self persistTaskMarker: info.marker
                    forTask: task
                  inContext: context];
    
    // Store task rool level
    [self persistTaskRoomLevel: info.roomLevel
                       forTask: task
                     inContext: context];
    
    // Store task rooms
    [info.rooms enumerateObjectsUsingBlock: ^(TaskRoomModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self persistTaskRoom: obj
                      forTask: task
                    inContext: context];
        
    }];
    
    // Store subtasks
    [info.subTasks.list enumerateObjectsUsingBlock: ^(ProjectTaskModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [self persistTaskWithInfo: obj
                       forProject: project
                        inContext: context];
        
    }];
    
    // Store tasks role assignments
    [info.taskRoleAssignments enumerateObjectsUsingBlock: ^(TaskRoleAssignmentsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
       
        [self persistTaskRoleAssignments: obj
                                 forTask: task
                               inContext: context];
        
    }];
    
}

- (void) persistTaskResponsible: (TaskResponsibleModel*)   info
                        forTask: (ProjectTask*)            task
                      inContext: (NSManagedObjectContext*) context
{
    ProjectTaskResponsible* responsible = [ProjectTaskResponsible MR_findFirstOrCreateByAttribute: @"responsibleID"
                                                                                        withValue: @(info.responsibleID)
                                                                                        inContext: context];
    
    responsible.responsibleID     = @(info.responsibleID);
    responsible.invite            = @(info.invite);
    responsible.isBlocked         = @(info.isBlocked);
    responsible.projectPermission = @(info.projectPermission);
    responsible.task              = task;
    
    // Store responsible assignee
    [self persistAssignee: info.assignee
           forResponsible: responsible
                inContext: context];
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
    assignee.emailConfirmed                   = @(info.emailConfirmed);
    assignee.firstName                        = info.firstName;
    assignee.assigneeID                       = @(info.assigneeID);
    assignee.isSubscribedOnEmailNotifications = @(info.isSubscribedOnEmailNotifications);
    assignee.isTourViewed                     = @(info.isTourViewed);
    assignee.lastName                         = info.lastName;
    assignee.phoneNumber                      = info.phoneNumber;
    assignee.userName                         = info.userName;
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
    stage.task     = task;
    stage.project  = project;
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

- (void) persistTaskRoom: (TaskRoomModel*)         info
                 forTask: (ProjectTask*)            task
               inContext: (NSManagedObjectContext*) context
{
    ProjectTaskRoom* room = [ProjectTaskRoom MR_findFirstOrCreateByAttribute: @"roomID"
                                                                   withValue: @(info.roomID)
                                                                   inContext: context];
    
    room.task                = task;
    room.roomID              = @(info.roomID);
    room.number              = @(info.number);
    room.roomLevelId         = @(info.roomLevelId);
    room.tasksCount          = @(info.tasksCount);
    room.tasksWithoutMarkers = @(info.tasksWithoutMarkers);
    room.title               = info.title;
    
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

@end
