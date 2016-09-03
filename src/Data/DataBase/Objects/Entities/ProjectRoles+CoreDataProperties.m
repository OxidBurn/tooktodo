//
//  ProjectRoles+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 9/4/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectRoles+CoreDataProperties.h"

@implementation ProjectRoles (CoreDataProperties)

@dynamic roleID;
@dynamic title;
@dynamic sort;
@dynamic projectID;
@dynamic hasProjectRoleAssignments;
@dynamic project;

@end
