//
//  ProjectTaskRoleAssignments+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectTaskRoleAssignments.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoleAssignments (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *roleAssignmentsID;
@property (nullable, nonatomic, retain) NSNumber *taskRoleType;
@property (nullable, nonatomic, retain) NSString *taskRoleTypeDescription;
@property (nullable, nonatomic, retain) NSManagedObject *task;

@end

NS_ASSUME_NONNULL_END
