//
//  DataManager+Roles.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+Roles.h"

// Classes
#import "ProjectRoleModel.h"
#import "ProjectRoleTypeModel.h"

// Categories
#import "DataManager+ProjectInfo.h"

@implementation DataManager (Roles)

#pragma mark - Public methods -

- (void) persistNewRoles: (NSArray*)              roles
          withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
     
        ProjectInfo* project = [DataManagerShared getSelectedProjectInfoInContext: localContext];
        
        [roles enumerateObjectsUsingBlock: ^(ProjectRoleModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistNewRole: obj
                      forProject: project
                       inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (void) persistNewDefaultRoles: (NSArray*)              roles
                 withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        [roles enumerateObjectsUsingBlock: ^(ProjectRoleModel* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistNewRole: obj
                       inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}

- (void) persistNewRole: (NewProjectRoleTypeModel*) info
         withCompletion: (CompletionWithSuccess)    completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
        
        ProjectInfo* selectedProject = [DataManagerShared getSelectedProjectInfoInContext: localContext];
        
        [self persistCreatedRoleType: info
                          forProject: selectedProject
                           inContext: localContext];
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if (completion)
                              completion(contextDidSave);
                          
                      }];
}


#pragma mark - Internal methods -

- (NSArray*) getAllRolesInCurrentProject
{
    ProjectInfo* currentProject = [DataManagerShared getSelectedProjectInfo];
    
    NSSortDescriptor* alphabeticalSort = [NSSortDescriptor sortDescriptorWithKey: @"title"
                                                                       ascending: YES];
    
    NSArray* roles = [currentProject.roles.allObjects sortedArrayUsingDescriptors: @[alphabeticalSort]];
    
    return roles;
}


#pragma mark - Internal methods -

- (void) persistNewRole: (ProjectRoleModel*)      info
             forProject: (ProjectInfo*)            project
              inContext: (NSManagedObjectContext*) context
{
    ProjectRoles* role = [self getRolesWithID: info.roleID
                                    inProject: project
                                    inContext: context];
    
    if ( role == nil )
    {
        role = [ProjectRoles MR_createEntityInContext: context];
        
        role.roleID                    = info.roleID;
        role.title                     = info.title;
        role.sort                      = info.sort;
        role.projectID                 = info.projectId;
        role.isDefault                 = @(NO);
        role.project                   = project;
        role.hasProjectRoleAssignments = @(info.hasProjectRoleAssignments);
    }
    else
    {
        role.title                     = info.title;
        role.sort                      = info.sort;
        role.projectID                 = info.projectId;
        role.project                   = project;
        role.hasProjectRoleAssignments = @(info.hasProjectRoleAssignments);
    }
}

- (void) persistNewRole: (ProjectRoleModel*)      info
              inContext: (NSManagedObjectContext*) context
{
    ProjectRoles* role = [self getRolesWithID: info.roleID
                                    inContext: context];
    
    if ( role == nil )
    {
        role = [ProjectRoles MR_createEntityInContext: context];
        
        role.roleID                    = info.roleID;
        role.title                     = info.title;
        role.projectID                 = @0;
        role.isDefault                 = @(YES);
        role.hasProjectRoleAssignments = @(NO);
    }
    else
    {
        role.roleID = info.roleID;
        role.title  = info.title;
    }
}

- (void) persistCreatedRoleType: (NewProjectRoleTypeModel*) info
                     forProject: (ProjectInfo*)             project
                      inContext: (NSManagedObjectContext*)  context
{
    ProjectRoleTypeModel* roleTypeModel = info.data;
    
    NSPredicate* findPredicate = [NSPredicate predicateWithFormat: @"roleID == %@ AND project == %@", roleTypeModel.roleTypeID, project];
    
    ProjectRoles* role = [ProjectRoles MR_findFirstWithPredicate: findPredicate
                                                       inContext: context];
    
    if ( role == nil )
    {
        role = [ProjectRoles MR_createEntityInContext: context];
    }
    
    role.roleID  = roleTypeModel.roleTypeID;
    role.title   = roleTypeModel.title;
    role.project = project;
}


- (ProjectRoles*) getRolesWithID: (NSNumber*)               roleID
                       inProject: (ProjectInfo*)            project
                       inContext: (NSManagedObjectContext*) context
{
    NSPredicate* findPredicate = [NSPredicate predicateWithFormat: @"roleID == %@ AND project == %@", roleID, project];
    
    ProjectRoles* role = [ProjectRoles MR_findFirstWithPredicate: findPredicate
                                                       inContext: context];
    
    return role;
}

- (NSArray*) getAllDefaultRoles
{
    return [ProjectRoles MR_findByAttribute: @"isDefault"
                                  withValue: @(YES)
                                 andOrderBy: @"title"
                                  ascending: YES];
}

@end
