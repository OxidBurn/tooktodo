//
//  DataManager+Roles.m
//  TookTODO
//
//  Created by Nikolay Chaban on 9/4/16.
//  Copyright © 2016 Nikolay Chaban. All rights reserved.
//

#import "DataManager+Roles.h"

// Classes
#import "ProjectRoleObject.h"

// Categories
#import "DataManager+ProjectInfo.h"

@implementation DataManager (Roles)

#pragma mark - Public methods -

- (void) persistNewRoles: (NSArray*)              roles
          withCompletion: (CompletionWithSuccess) completion
{
    [MagicalRecord saveWithBlock: ^(NSManagedObjectContext * _Nonnull localContext) {
     
        ProjectInfo* project = [DataManagerShared getSelectedProjectInfoInContext: localContext];
        
        [roles enumerateObjectsUsingBlock: ^(ProjectRoleObject* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
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
        
        [roles enumerateObjectsUsingBlock: ^(ProjectRoleObject* obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [self persistNewRole: obj
                       inContext: localContext];
            
        }];
        
    }
                      completion: ^(BOOL contextDidSave, NSError * _Nullable error) {
                          
                          if ( completion )
                              completion(contextDidSave);
                          
                      }];
}


- (NSArray*) getAllRolesInCurrentProject
{
    ProjectInfo* currentProject = [DataManagerShared getSelectedProjectInfo];
    
    NSSortDescriptor* alphabeticalSort = [NSSortDescriptor sortDescriptorWithKey: @"title"
                                                                       ascending: YES];
    
    NSArray* roles = [currentProject.roles.allObjects sortedArrayUsingDescriptors: @[alphabeticalSort]];
    
    return roles;
}


#pragma mark - Internal methods -

- (void) persistNewRole: (ProjectRoleObject*)      info
             forProject: (ProjectInfo*)            project
              inContext: (NSManagedObjectContext*) context
{
    ProjectRoles* role = [self getRolesWithID: info.roleID
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
}

- (void) persistNewRole: (ProjectRoleObject*)      info
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
}

- (ProjectRoles*) getRolesWithID: (NSNumber*)               roleID
                       inContext: (NSManagedObjectContext*) context
{
    return [ProjectRoles MR_findFirstByAttribute: @"roleID"
                                       withValue: roleID
                                       inContext: context];
}

- (NSArray*) getAllDefaultRoles
{
    return [ProjectRoles MR_findByAttribute: @"isDefault"
                                  withValue: @(YES)
                                 andOrderBy: @"title"
                                  ascending: YES];
}

@end
