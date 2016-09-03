//
//  ProjectRoles+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/4/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectRoles.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectRoles (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *roleID;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSNumber *sort;
@property (nullable, nonatomic, retain) NSNumber *projectID;
@property (nullable, nonatomic, retain) NSNumber *hasProjectRoleAssignments;
@property (nullable, nonatomic, retain) ProjectInfo *project;

@end

NS_ASSUME_NONNULL_END
