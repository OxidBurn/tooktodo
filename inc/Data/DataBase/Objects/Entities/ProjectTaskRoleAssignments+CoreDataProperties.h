//
//  ProjectTaskRoleAssignments+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 24.11.16.
//
//

#import "ProjectTaskRoleAssignments+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoleAssignments (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoleAssignments *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *roleAssignmentsID;
@property (nullable, nonatomic, copy) NSNumber *taskRoleType;
@property (nullable, nonatomic, copy) NSString *taskRoleTypeDescription;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskRoleAssignment *> *projectRoleAssignment;
@property (nullable, nonatomic, retain) ProjectTask *task;

@end

@interface ProjectTaskRoleAssignments (CoreDataGeneratedAccessors)

- (void)addProjectRoleAssignmentObject:(ProjectTaskRoleAssignment *)value;
- (void)removeProjectRoleAssignmentObject:(ProjectTaskRoleAssignment *)value;
- (void)addProjectRoleAssignment:(NSSet<ProjectTaskRoleAssignment *> *)values;
- (void)removeProjectRoleAssignment:(NSSet<ProjectTaskRoleAssignment *> *)values;

@end

NS_ASSUME_NONNULL_END
