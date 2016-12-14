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
#import "ProjectTaskOwner+CoreDataProperties.h"
#import "ProjectTaskStage+CoreDataClass.h"
#import "ProjectTaskMarker.h"
#import "ProjectTaskAssignee+CoreDataClass.h"
#import "ProjectTaskRoleType.h"
#import "ProjectTaskWorkArea+CoreDataClass.h"
#import "ProjectTaskRoomLevel+CoreDataClass.h"
#import "ProjectTaskMapContour+CoreDataClass.h"
#import "ProjectTaskResponsible+CoreDataClass.h"
#import "ProjectTaskRoleAssignment+CoreDataClass.h"
#import "ProjectTaskRoleAssignments+CoreDataClass.h"
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
#import "TaskApprovementsModel.h"
#import "ProjectTaskRoleAssignment+CoreDataProperties.h"
#import "ProjectTaskStageModel.h"
#import "ProjectStageTasksListModel.h"

// Categories
#import "DataManager+ProjectInfo.h"
#import "DataManager+Room.h"
#import "DataManager+TaskApprovements.h"

@implementation DataManager (Tasks)


#pragma mark - Public methods -

- (void) persistTasks: (NSArray*)              tasks
       withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        // Get selected project info
        // For storing
        ProjectInfo* project = [DataManagerShared getSelectedProjectInfoInContext: localContext];
        
        [tasks enumerateObjectsUsingBlock: ^(ProjectTaskStageModel* stageModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistStageWithInfo: stageModel
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

- (void) updateStatusType: (NSNumber*)             newStatus
    withStatusDescription: (NSString*)             statusDescription
           withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectTask* selectedTask = [self getSelectedTask];
        
        ProjectTask* task = [ProjectTask MR_findFirstByAttribute: @"taskID"
                                                       withValue: selectedTask.taskID
                                                       inContext: localContext];
        task.status            = newStatus;
        task.statusDescription = statusDescription;
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                      }];
}

- (void) persistNewSubtask: (ProjectTaskModel*)     info
            withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectTask* selectedTask    = [DataManagerShared getSelectedTaskInContext: localContext];
        ProjectInfo* selectedProject = [DataManagerShared getSelectedProjectInfoInContext: localContext];
        
        ProjectTask* newSubTask = [self persistTaskWithInfo: info
                                                 forProject: selectedProject
                                                  inContext: localContext];
        
        [selectedTask addSubTasksObject: newSubTask];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (void) deleteTaskWithInfo: (ProjectTask*)          task
                withSubtask: (BOOL)                  subtask
             withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        if ( subtask )
        {
            [task.subTasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull subTask, BOOL * _Nonnull stop) {
               
                [subTask MR_deleteEntityInContext: localContext];
                
            }];
        }
        else
            if ( task.subTasks.count > 0 )
            {
                [task.subTasks enumerateObjectsUsingBlock: ^(ProjectTask * _Nonnull subTask, BOOL * _Nonnull stop) {
                    
                    subTask.parentTaskId = nil;
                    subTask.stage        = task.stage;
                    
                }];
            }
        
        [task MR_deleteEntityInContext: localContext];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

#pragma mark - Internal methods -

- (void) persistStageWithInfo: (ProjectTaskStageModel*)  info
                   forProject: (ProjectInfo*)            project
                    inContext: (NSManagedObjectContext*) context
{
    ProjectTaskStage* stage = [ProjectTaskStage MR_findFirstOrCreateByAttribute: @"stageID"
                                                                      withValue: info.stageID
                                                                      inContext: context];
    
    stage.project  = project;
    stage.stageID  = info.stageID;
    stage.isCommon = info.isCommon;
    stage.title    = info.title;
    
    [info.tasks.list enumerateObjectsUsingBlock: ^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        ProjectTask* task = [self persistTaskWithInfo: obj
                                           forProject: project
                                            inContext: context];
        
        task.stage = stage;
        
    }];
}

- (ProjectTask*) persistTaskWithInfo: (ProjectTaskModel*)       info
                          forProject: (ProjectInfo*)            project
                           inContext: (NSManagedObjectContext*) context
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"taskID == %@ AND projectId == %@", info.taskID, info.projectId];
    
    ProjectTask* task = [ProjectTask MR_findFirstWithPredicate: predicate
                                                     inContext: context];
    
    if ( task == nil )
    {
        task = [ProjectTask MR_createEntityInContext: context];
    }
    
    task.isSelected = @NO;
    
    [self fillTaskInfoForTask: task
                    inProject: project
                     withInfo: info
                    inContext: context];
    
    return task;
}

- (void) persistTaskResponsible: (TaskResponsibleModel*)   info
                        forTask: (ProjectTask*)            task
                      inContext: (NSManagedObjectContext*) context
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"responsibleID == %@ AND task == %@", info.responsibleID, task];
    
    ProjectTaskResponsible* responsible = [ProjectTaskResponsible MR_findFirstWithPredicate: predicate
                                                                                  inContext: context];
    
    if ( responsible == nil )
    {
        responsible = [ProjectTaskResponsible MR_createEntityInContext: context];
    }
    
    responsible.responsibleID     = info.responsibleID;
    responsible.isBlocked         = info.isBlocked;
    responsible.projectPermission = info.projectPermission;
    responsible.firstName         = info.firstName;
    responsible.lastName          = info.lastName;
    responsible.displayName       = info.displayName;
    responsible.avatarSrc         = info.avatarSrc;
    responsible.task              = task;
    responsible.isActiveUser      = info.isActiveUser;
    
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
    NSPredicate* searchPredicate = [NSPredicate predicateWithFormat: @"assigneeID == %@ AND responsible == %@", @(info.assigneeID), responsbile];
    
    ProjectTaskAssignee* assignee = [ProjectTaskAssignee MR_findFirstWithPredicate: searchPredicate
                                                                         inContext: context];
    
    if ( assignee == nil )
    {
        assignee = [ProjectTaskAssignee MR_createEntityInContext: context];
    }
    
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
    NSPredicate* searchPredicate = [NSPredicate predicateWithFormat: @"inviteID == %@ AND projectTaskResponsible == %@", info.inviteID, responsbile];
    
    ProjectInviteInfo* invite = [ProjectInviteInfo MR_findFirstWithPredicate: searchPredicate
                                                                   inContext: context];
    
    if ( invite == nil )
    {
        invite = [ProjectInviteInfo MR_createEntityInContext: context];
    }
    
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
    NSPredicate* searchPredicate = [NSPredicate predicateWithFormat: @"roleTypeID == %@ AND projectInvite == %@", info.roleTypeID, invite];
    
    ProjectRoleType* roleType = [ProjectRoleType MR_findFirstWithPredicate: searchPredicate
                                                                 inContext: context];
    
    if ( roleType == nil )
    {
        roleType = [ProjectRoleType MR_createEntityInContext: context];
    }
    
    roleType.projectInvite  = invite;
    roleType.roleTypeID     = info.roleTypeID;
    roleType.title          = info.title;
}

- (void) persistRoleAssignment: (TaskProjectRoleAssignmentModel*) info
            forTaskAssignments: (ProjectTaskRoleAssignments*)     assignments
                     inContext: (NSManagedObjectContext*)         context
{
    ProjectTaskRoleAssignment* roleAssignment = [self getAssignmentWithID: info.taskRoleAssignmnetID
                                                        inRoleAssignments: assignments
                                                                inContext: context];
    
    if ( roleAssignment == nil )
    {
        roleAssignment = [ProjectTaskRoleAssignment MR_createEntityInContext: context];
        
        roleAssignment.projectRoleAssignments = assignments;
        roleAssignment.taskRoleAssignmnetID   = info.taskRoleAssignmnetID;
    }
    
    roleAssignment.projectPermission = info.projectPermission;
    roleAssignment.isBlocked         = info.isBlocked;
    
    if ( info.assignee )
    {
        [self persistTaskAssignee: info.assignee
            forTaskRoleAssignment: roleAssignment
                        inContext: context];
    }
    
    if ( info.invite )
    {
        [self persistTaskInvite: info.invite
          forTaskRoleAssignment: roleAssignment
                      inContext: context];
    }
    
    if ( info.projectRoleType )
    {
        [self persistTaskProjectRoleType: info.projectRoleType
                        inRoleAssignment: roleAssignment
                               inContext: context];
    }
}

- (void) persistTaskAssignee: (TaskAssigneeModel*)         info
       forTaskRoleAssignment: (ProjectTaskRoleAssignment*) assignment
                   inContext: (NSManagedObjectContext*)    context
{
    ProjectTaskAssignee* assignee = [self getProjectTaskAssigneeWithID: @(info.assigneeID)
                                                      inRoleAssignment: assignment
                                                             inContext: context];
    
    if ( assignee == nil )
    {
        assignee = [ProjectTaskAssignee MR_createEntityInContext: context];
        
        assignee.roleAssignment = assignment;
        assignee.assigneeID     = @(info.assigneeID);
    }
    
    assignee.additionalPhoneNumber            = info.additionalPhoneNumber;
    assignee.avatarSrc                        = info.avatarSrc;
    assignee.displayName                      = info.displayName;
    assignee.email                            = info.email;
    assignee.emailConfirmed                   = info.emailConfirmed;
    assignee.firstName                        = info.firstName;
    assignee.isSubscribedOnEmailNotifications = info.isSubscribedOnEmailNotifications;
    assignee.isTourViewed                     = info.isTourViewed;
    assignee.lastName                         = info.lastName;
    assignee.phoneNumber                      = info.phoneNumber;
    assignee.userName                         = info.userName;
}

- (void) persistTaskInvite: (ProjectInviteInfoModel*)    info
     forTaskRoleAssignment: (ProjectTaskRoleAssignment*) assignment
                 inContext: (NSManagedObjectContext*)    context
{
    ProjectInviteInfo* invite = [self getInviteWithID: info.inviteID
                              inProjectRoleAssignment: assignment
                                            inContext: context];
    
    if ( invite == nil )
    {
        invite = [ProjectInviteInfo MR_createEntityInContext: context];
        
        invite.inviteID              = info.inviteID;
        invite.projectTaskAssignment = assignment;
    }
    
    invite.email        = info.email;
    invite.firstName    = info.firstName;
    invite.lastName     = info.lastName;
    invite.isUsed       = info.isUsed;
    invite.isCanceled   = info.isCanceled;
    invite.inviteStatus = info.inviteStatus;
    invite.message      = info.message;
    invite.projectId    = info.projectId;
    invite.projectName  = info.projectName;
}

- (void) persistTaskProjectRoleType: (TaskProjectRoleTypeModel*)  info
                   inRoleAssignment: (ProjectTaskRoleAssignment*) assignment
                          inContext: (NSManagedObjectContext*)    context
{
    ProjectTaskRoleType* roleType = [self getRoleTypeWithID: @(info.roleTypeID)
                                           inRoleAssignment: assignment
                                                  inContext: context];
    
    if ( roleType == nil )
    {
        roleType = [ProjectTaskRoleType MR_createEntityInContext: context];
        
        roleType.roleTypeID     = @(info.roleTypeID);
        roleType.roleAssignment = assignment;
    }
    
    roleType.title = info.title;
}

- (ProjectTaskStage*) persistTaskStage: (TaskStageModel*)         info
                               forTask: (ProjectTask*)            task
                             inProject: (ProjectInfo*)            project
                             inContext: (NSManagedObjectContext*) context
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"stageID == %@", @(info.stageID)];
    
    ProjectTaskStage* stage = [ProjectTaskStage MR_findFirstWithPredicate: predicate
                                                                inContext: context];
    
    if ( stage == nil && stage.project != project )
    {
        stage = [ProjectTaskStage MR_createEntityInContext: context];
        
        stage.stageID = @(info.stageID);
        stage.project = project;
        
        NSLog(@"Stage with id: %lu", (unsigned long)info.stageID);
        NSLog(@"<INFO> In project %@", project.title);
    }
    
    stage.isCommon = @(info.isCommon);
    stage.title    = info.title;
    
    return stage;
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
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"ownerID == %@ AND task == %@", @(info.ownerID), task];
    
    ProjectTaskOwner* ownerUser = [ProjectTaskOwner MR_findFirstWithPredicate: predicate
                                                                    inContext: context];
    
    if ( ownerUser == nil )
    {
        ownerUser = [ProjectTaskOwner MR_createEntityInContext: context];
    }
    
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

- (void) persistTaskRoleAssignments: (TaskRoleAssignmentsModel*) info
                            forTask: (ProjectTask*)              task
                          inContext: (NSManagedObjectContext*)   context
{    
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"roleAssignmentsID == %@ AND task == %@", @(info.roleAssignmentsID), task];
    
    ProjectTaskRoleAssignments* roleAssignments = [ProjectTaskRoleAssignments MR_findFirstWithPredicate: predicate
                                                                                              inContext: context];
    
    if ( roleAssignments == nil )
    {
        roleAssignments = [ProjectTaskRoleAssignments MR_createEntityInContext: context];
    }
    
    roleAssignments.task                    = task;
    roleAssignments.roleAssignmentsID       = @(info.roleAssignmentsID);
    roleAssignments.taskRoleType            = @(info.taskRoleType);
    roleAssignments.taskRoleTypeDescription = info.taskRoleTypeDescription;
    
    [self persistRoleAssignment: info.projectRoleAssignment
             forTaskAssignments: roleAssignments
                      inContext: context];
}

- (void) updateSelectedTaskInfo: (ProjectTask*)          task
                    withNewInfo: (ProjectTaskModel*)     info
                 withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectTask* updatedTask = [task MR_inContext: localContext];
        
        [self fillTaskInfoForTask: updatedTask
                        inProject: updatedTask.project
                         withInfo: info
                        inContext: localContext];
        
        NSLog(@"<INFO> Updated task info: %@", updatedTask);
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (void) updateExpandedStateOfStage: (ProjectTaskStage*)     stageInfo
                     withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectTaskStage* stage = [stageInfo MR_inContext: localContext];
        
        stage.isExpanded = @(!stage.isExpanded.boolValue);
        
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
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectRoleAssignments* selectedRoleAssignment = [[self getSelectedProjectRoleAssignment] MR_inContext: localContext];
        
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
    
    NSArray* stages = currentProject.stage.array;
    
    return stages;
}

- (void) updateSelectedStateForTask: (ProjectTask*)          task
                  withSelectedState: (BOOL)                  isSelected
                     withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        if ( isSelected ) // if user selected new task, need to check and deselect all tasks of the project in DB
        {
            [self deselectAllSelectedTasksInContext: localContext];
        }
        
        ProjectTask* selectedTask = [task MR_inContext: localContext];
        
        selectedTask.isSelected = @(isSelected);
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (void) deselectAllSelectedTasksInContext: (NSManagedObjectContext*) context
{
    NSArray* selectedProjectTasks = [ProjectTask MR_findAllWithPredicate: [NSPredicate predicateWithFormat: @"isSelected == YES"]
                                                               inContext: context];
    
    [selectedProjectTasks enumerateObjectsUsingBlock: ^(ProjectTask* task, NSUInteger idx, BOOL * _Nonnull stop) {
        
        task.isSelected = @(NO);
        
    }];
}

- (ProjectTask*) getSelectedTask
{
    ProjectTask* task = [ProjectTask MR_findFirstByAttribute: @"isSelected"
                                                   withValue: @(YES)];
    
    return task;
}

- (ProjectTask*) getSelectedTaskInContext: (NSManagedObjectContext*) context
{
    ProjectTask* task = [ProjectTask MR_findFirstByAttribute: @"isSelected"
                                                   withValue: @(YES)
                                                   inContext: context];
    
    return task;
}

- (ProjectTaskRoleAssignment*) getAssignmentWithID: (NSNumber*)                   assignmentID
                                 inRoleAssignments: (ProjectTaskRoleAssignments*) assignments
                                         inContext: (NSManagedObjectContext*)     context
{
    NSPredicate* findPredicate = [NSPredicate predicateWithFormat: @"taskRoleAssignmnetID == %@ AND projectRoleAssignments == %@", assignmentID, assignments];
    
    ProjectTaskRoleAssignment* roleAssignment = [ProjectTaskRoleAssignment MR_findFirstWithPredicate: findPredicate
                                                                                           inContext: context];
    
    return roleAssignment;
}

- (ProjectTaskAssignee*) getProjectTaskAssigneeWithID: (NSNumber*)                  assigneeID
                                     inRoleAssignment: (ProjectTaskRoleAssignment*) assignment
                                            inContext: (NSManagedObjectContext*)    context
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"assigneeID == %@ AND roleAssignment == %@", assigneeID, assignment];
    
    ProjectTaskAssignee* assignee = [ProjectTaskAssignee MR_findFirstWithPredicate: predicate
                                                                         inContext: context];
    
    return assignee;
}

- (ProjectInviteInfo*) getInviteWithID: (NSNumber*)                  inviteID
               inProjectRoleAssignment: (ProjectTaskRoleAssignment*) assignment
                             inContext: (NSManagedObjectContext*)    context
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"inviteID == %@ AND projectTaskAssignment == %@", inviteID, assignment];
    
    ProjectInviteInfo* invite = [ProjectInviteInfo MR_findFirstWithPredicate: predicate
                                                                   inContext: context];
    
    return invite;
}

- (ProjectTaskRoleType*) getRoleTypeWithID: (NSNumber*)                  roleTypeID
                          inRoleAssignment: (ProjectTaskRoleAssignment*) assignment
                                 inContext: (NSManagedObjectContext*)    context
{
    NSPredicate* predicate = [NSPredicate predicateWithFormat: @"roleTypeID == %@ AND roleAssignment == %@", roleTypeID, assignment];
    
    ProjectTaskRoleType* roleType = [ProjectTaskRoleType MR_findFirstWithPredicate: predicate
                                                                         inContext: context];
    
    return roleType;
}

- (void) fillTaskInfoForTask: (ProjectTask*)            task
                   inProject: (ProjectInfo*)            project
                    withInfo: (ProjectTaskModel*)       info
                   inContext: (NSManagedObjectContext*) context
{
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
    
    task.commentsCount    = info.commentsCount;
    task.factualStartDate = info.factualStartDate;
    task.factualEndDate   = info.factualEndDate;
    
    // Store task responsible
    if ( info.responsible )
    {
        [self persistTaskResponsible: info.responsible
                             forTask: task
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
        NSArray* subTasksList = @[];
        
        if ( [info.subTasks isKindOfClass: [NSArray class]] )
        {
            subTasksList = info.subTasks;
        }
        else
        {
            TaskSubTasksModel* subTasksModel = (TaskSubTasksModel*)info.subTasks;
            
            subTasksList = subTasksModel.list;
        }
        
        [subTasksList enumerateObjectsUsingBlock: ^(ProjectTaskModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ProjectTask* subTask = [self persistTaskWithInfo: obj
                                                  forProject: project
                                                   inContext: context];
            
            [task addSubTasksObject: subTask];
            
        }];
    }
    
    // Store tasks role assignments
    if ( info.taskRoleAssignments )
    {
        [info.taskRoleAssignments enumerateObjectsUsingBlock: ^(TaskRoleAssignmentsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistTaskRoleAssignments: obj
                                     forTask: task
                                   inContext: context];
            
        }];
    }
    
    // Task approvements
    if ( info.approvments )
    {
        [info.approvments enumerateObjectsUsingBlock: ^(TaskApprovementsModel* approvementModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistNewTaskApprovements: approvementModel
                                     forTask: task
                                   inContext: context];
            
        }];
    }
}

@end
