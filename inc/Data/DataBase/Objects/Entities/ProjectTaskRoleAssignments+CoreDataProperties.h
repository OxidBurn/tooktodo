//
//  ProjectTaskRoleAssignments+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/23/16.
//
//

#import "ProjectTaskRoleAssignments+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoleAssignments (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoleAssignments *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *roleAssignmentsID;
@property (nullable, nonatomic, copy) NSNumber *taskRoleType;
@property (nullable, nonatomic, copy) NSString *taskRoleTypeDescription;
@property (nullable, nonatomic, retain) ProjectTask *task;
@property (nullable, nonatomic, retain) ProjectTaskRoleAssignment *projectRoleAssignment;

@end

NS_ASSUME_NONNULL_END
