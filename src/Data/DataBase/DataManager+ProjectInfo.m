//
//  DataManager+ProjectInfo.m
//  TookTODO
//
//  Created by Nikolay Chaban on 8/22/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+ProjectInfo.h"

// Classes
#import "OfflineSettings.h"
#import "OfflineSettingsTypes.h"
#import "ProjectCountryModel.h"
#import "ProjectCountry.h"
#import "ProjectRegion.h"
#import "ProjectRegionModel.h"
#import "TaskAssigneeModel.h"
#import "ProjectTaskAssignee+CoreDataClass.h"
#import "ProjectRoleAssignmentsModel.h"
#import "ProjectRoleAssignments+CoreDataClass.h"
#import "ProjectRoleType+CoreDataProperties.h"
#import "ProjectInviteInfo+CoreDataClass.h"
#import "ProjectInviteInfoModel.h"

@implementation DataManager (ProjectInfo)


#pragma mark - Creation methods -

- (void) persistNewProjects: (NSArray*)  projects
             withCompletion: (void(^)()) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        [projects enumerateObjectsUsingBlock: ^(ProjectInfoModel* data, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistNewProjectWithInfo: data
                                  inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion();
                          
                      }];
}

- (void) persistNewProjectWithInfo: (ProjectInfoModel*)        data
                         inContext: (NSManagedObjectContext*) context
{
    ProjectInfo* projectInfo = [ProjectInfo MR_findFirstOrCreateByAttribute: @"projectID"
                                                                  withValue: @(data.projectID)
                                                                  inContext: context];
    
    projectInfo.lastVisit                        = data.lastVisit;
    projectInfo.isTaskAddAppealClosed            = @(data.isTaskAddAppealClosed);
    projectInfo.realtyClassDescription           = data.realtyClassDescription;
    projectInfo.title                            = data.title;
    projectInfo.ownerUserId                      = @(data.ownerUserId);
    projectInfo.street                           = data.street;
    projectInfo.residentialObjectType            = @(data.residentialObjectType);
    projectInfo.building                         = data.building;
    projectInfo.city                             = data.city;
    projectInfo.residentialObjectTypeDescription = data.residentialObjectTypeDescription;
    projectInfo.regionName                       = data.regionName;
    projectInfo.apartment                        = data.apartment;
    projectInfo.endDate                          = data.endDate;
    projectInfo.projectID                        = @(data.projectID);
    projectInfo.createdDate                      = data.createdDate;
    projectInfo.isRolesInvitationAppealClosed    = @(data.isRolesInvitationAppealClosed);
    projectInfo.commercialObjectType             = @(data.commercialObjectType);
    projectInfo.realtyClass                      = @(data.realtyClass);
    projectInfo.phoneNumber                      = data.phoneNumber;
    projectInfo.commercialObjectTypeDescription  = data.commercialObjectTypeDescription;
    projectInfo.floor                            = data.floor;
    projectInfo.address                          = [NSString stringWithFormat: @"%@ %@ %@ %@", data.regionName, data.city, data.street, data.building];
    
    if ( data.projectRoleAssignments )
    {
        [data.projectRoleAssignments enumerateObjectsUsingBlock: ^(ProjectRoleAssignmentsModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistProjectRoleAssignment: obj
                                    forProject: projectInfo
                                     inContext: context];
            
        }];
    }
    
}

- (void) persistProjectRoleAssignment: (ProjectRoleAssignmentsModel*) info
                           forProject: (ProjectInfo*)                 project
                            inContext: (NSManagedObjectContext*)      context
{
    ProjectRoleAssignments* roleAssignment = [ProjectRoleAssignments MR_findFirstOrCreateByAttribute: @"roleID"
                                                                                           withValue: info.roleID
                                                                                           inContext: context];
    
    roleAssignment.roleID            = info.roleID;
    roleAssignment.isBlocked         = @(info.isBlocked);
    roleAssignment.projectPermission = @(info.projectPermission);
    roleAssignment.project           = project;
    
    if ( info.assignee )
    {
        [self persistProjectRoleAssignee: info.assignee
                      forRoleAssignments: roleAssignment
                               inContext: context];
    }
    
    if ( info.invite )
    {
        [self persistProjectRoleAssignmentInviteInfo: info.invite
                                    forRoleAssigment: roleAssignment
                                           inContext: context];
    }
    
    if ( info.projectRoleType )
    {
        [self persistProjectRoleType: info.projectRoleType
                  forRoleAssignments: roleAssignment
                           inContext: context];
    }
}

- (void) persistProjectRoleAssignee: (TaskAssigneeModel*)      info
                 forRoleAssignments: (ProjectRoleAssignments*) role
                          inContext: (NSManagedObjectContext*) context
{
    ProjectTaskAssignee* assignee = [ProjectTaskAssignee MR_findFirstOrCreateByAttribute: @"assigneeID"
                                                                               withValue: @(info.assigneeID)
                                                                               inContext: context];
    
    assignee.projectRoleAssignment            = role;
    assignee.assigneeID                       = @(info.assigneeID);
    assignee.email                            = info.email;
    assignee.firstName                        = info.firstName;
    assignee.lastName                         = info.lastName;
    assignee.displayName                      = info.displayName;
    assignee.avatarSrc                        = info.avatarSrc;
    assignee.phoneNumber                      = info.phoneNumber;
    assignee.additionalPhoneNumber            = info.additionalPhoneNumber;
    assignee.isSubscribedOnEmailNotifications = info.isSubscribedOnEmailNotifications;
    assignee.isTourViewed                     = info.isTourViewed;
}

- (void) persistProjectRoleType: (ProjectRoleTypeModel*)   info
             forRoleAssignments: (ProjectRoleAssignments*) role
                      inContext: (NSManagedObjectContext*) context
{
    ProjectRoleType* roleType = [ProjectRoleType MR_findFirstOrCreateByAttribute: @"roleTypeID"
                                                                       withValue: info.roleTypeID
                                                                       inContext: context];
    
    roleType.roleAssignment = role;
    roleType.roleTypeID     = info.roleTypeID;
    roleType.title          = info.title;
}

- (void) persistProjectRoleType: (ProjectRoleTypeModel*)   info
               forProjectInvite: (ProjectInviteInfo*)      invite
                      inContext: (NSManagedObjectContext*) context
{
    ProjectRoleType* roleType = [ProjectRoleType MR_findFirstOrCreateByAttribute: @"roleTypeID"
                                                                       withValue: info.roleTypeID
                                                                       inContext: context];
    
    roleType.projectInvite  = invite;
    roleType.roleTypeID     = info.roleTypeID;
    roleType.title          = info.title;
}

- (void) persistProjectRoleAssignmentInviteInfo: (ProjectInviteInfoModel*) info
                               forRoleAssigment: (ProjectRoleAssignments*) role
                                      inContext: (NSManagedObjectContext*) context
{
    ProjectInviteInfo* inviteInfo = [ProjectInviteInfo MR_findFirstOrCreateByAttribute: @""
                                                                             withValue: info.inviteID
                                                                             inContext: context];
    
    inviteInfo.projectRoleAssignment = role;
    inviteInfo.email                 = info.email;
    inviteInfo.firstName             = info.firstName;
    inviteInfo.lastName              = info.lastName;
    inviteInfo.inviteID              = info.inviteID;
    inviteInfo.inviteStatus          = info.inviteStatus;
    inviteInfo.isCanceled            = info.isCanceled;
    inviteInfo.isUsed                = info.isUsed;
    inviteInfo.message               = info.message;
    inviteInfo.projectId             = info.projectId;
    inviteInfo.projectName           = info.projectName;
    
    if ( info.projectRoleType )
    {
        [self persistProjectRoleType: info.projectRoleType
                    forProjectInvite: inviteInfo
                           inContext: context];
    }
}

- (void) persistSelectedProjectRoleAssignments: (NSArray*)              roleAssignemnts
                                withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectInfo* selectedProject = [self getSelectedProjectInfoInContext: localContext];
        
        [roleAssignemnts enumerateObjectsUsingBlock: ^(ProjectRoleAssignmentsModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistProjectRoleAssignment: obj
                                    forProject: selectedProject
                                     inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

#pragma mark - Get methods -

- (ProjectInfo*) getIfExistProjectWithID: (NSUInteger) projectID
{
    return [ProjectInfo MR_findFirstByAttribute: @"projectID"
                                      withValue: @(projectID)];
}

- (NSArray*) getAllProjects
{
    return [ProjectInfo MR_findAllSortedBy: @"title"
                                 ascending: YES];
}

- (NSArray*) getProjectsForMenu
{
    NSArray* allProjects = [ProjectInfo MR_findAllSortedBy: @"lastVisit"
                                                 ascending: YES];
    NSArray* menuProjectsList = nil;
    
    // Show only 4 projects in menu
    if ( allProjects.count > 4 )
    {
        menuProjectsList = @[allProjects[0],
                             allProjects[1],
                             allProjects[2],
                             allProjects[3]];
    }
    else
    {
        menuProjectsList = allProjects;
    }
    
    return menuProjectsList;
}

- (BOOL) deleteAllProjects
{
    BOOL isSuccess = [ProjectInfo MR_truncateAll];
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveOnlySelfAndWait];
    
    return isSuccess;
}

- (ProjectInfo*) getSelectedProjectInfo
{
    NSPredicate* selectedPredicate = [NSPredicate predicateWithFormat: @"isSelected == YES"];
    
    ProjectInfo* selectedProject = [ProjectInfo MR_findFirstWithPredicate: selectedPredicate];
    
    return selectedProject;
}

- (ProjectInfo*) getSelectedProjectInfoInContext: (NSManagedObjectContext*) context
{
    NSPredicate* selectedPredicate = [NSPredicate predicateWithFormat: @"isSelected == YES"];
    
    ProjectInfo* selectedProject = [ProjectInfo MR_findFirstWithPredicate: selectedPredicate
                                                                inContext: context];
    
    return selectedProject;
}

- (ProjectInfo*) getProjectWithID: (NSNumber*)               projectID
                         inCotext: (NSManagedObjectContext*) context
{
    ProjectInfo* project = [ProjectInfo MR_findFirstByAttribute: @"projectID"
                                                      withValue: projectID
                                                      inContext: context];
    
    return project;
}

- (NSString*) getSelectedProjectName
{
    ProjectInfo* projectInfo = [self getSelectedProjectInfo];
    
    return projectInfo.title;
}

- (NSArray*) getSelectedProjectRoleAssignments
{
    ProjectInfo* project = [self getSelectedProjectInfo];
    
    return project.projectRoleAssignments.allObjects;
}

#pragma mark - Updating methods -

- (void) markFirstProjectAsSelected
{
    [MagicalRecord saveWithBlockAndWait: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectInfo* firstProject = [ProjectInfo MR_findFirstInContext: localContext];
        
        firstProject.isSelected = @(YES);
        
    }];
}

- (void) markProjectAsSelected: (ProjectInfo*)            project
                withCompletion: (void(^)(BOOL isSuccess)) completion
{
    ProjectInfo* prevSelectedProject = [self getSelectedProjectInfo];
    
    prevSelectedProject.isSelected = @(NO);
    project.isSelected             = @(YES);
    
    [[NSManagedObjectContext MR_defaultContext] MR_saveToPersistentStoreWithCompletion: ^(BOOL contextDidSave, NSError * _Nullable error) {
        
        if ( completion )
            completion(contextDidSave);
        
    }];
}

- (OfflineSettings*) createOfflineSettingForProject: (ProjectInfo*)            project
                                          inContext: (NSManagedObjectContext*) context
{
    OfflineSettings* settings = [OfflineSettings MR_createEntityInContext: context];
    
    settings.project = project;
    settings.title = @"Задачи, Лента, Планы";
    settings.type  = @(TasksFeedsPlansType);
    
    
    return settings;
}

- (void) updateProjectExpandedState: (ProjectInfo*)          project
                     withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        project.isExpanded = @(!project.isExpanded.boolValue);
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (void) updateSelectedProjectPermission: (BOOL)                  permission
                          withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectInfo* selectedProject = [self getSelectedProjectInfoInContext: localContext];
        
        selectedProject.projectPermissiom = @(permission);
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (NSInteger) getSelectedProjectPermission
{
    ProjectInfo* selectedProjectInfo = [self getSelectedProjectInfo];
    
    return selectedProjectInfo.projectPermissiom.integerValue;
}

@end
