//
//  ProjectTaskRoleAssignments+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import "ProjectTaskRoleAssignments+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoleAssignments (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoleAssignments *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *roleAssignmentsID;
@property (nullable, nonatomic, copy) NSNumber *taskRoleType;
@property (nullable, nonatomic, copy) NSString *taskRoleTypeDescription;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTaskRoleAssignment *> *projectRoleAssignment;
@property (nullable, nonatomic, retain) ProjectTask *task;

@end

@interface ProjectTaskRoleAssignments (CoreDataGeneratedAccessors)

- (void)insertObject:(ProjectTaskRoleAssignment *)value inProjectRoleAssignmentAtIndex:(NSUInteger)idx;
- (void)removeObjectFromProjectRoleAssignmentAtIndex:(NSUInteger)idx;
- (void)insertProjectRoleAssignment:(NSArray<ProjectTaskRoleAssignment *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeProjectRoleAssignmentAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInProjectRoleAssignmentAtIndex:(NSUInteger)idx withObject:(ProjectTaskRoleAssignment *)value;
- (void)replaceProjectRoleAssignmentAtIndexes:(NSIndexSet *)indexes withProjectRoleAssignment:(NSArray<ProjectTaskRoleAssignment *> *)values;
- (void)addProjectRoleAssignmentObject:(ProjectTaskRoleAssignment *)value;
- (void)removeProjectRoleAssignmentObject:(ProjectTaskRoleAssignment *)value;
- (void)addProjectRoleAssignment:(NSOrderedSet<ProjectTaskRoleAssignment *> *)values;
- (void)removeProjectRoleAssignment:(NSOrderedSet<ProjectTaskRoleAssignment *> *)values;

@end

NS_ASSUME_NONNULL_END
