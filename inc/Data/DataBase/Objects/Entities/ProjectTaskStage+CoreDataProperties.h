//
//  ProjectTaskStage+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import "ProjectTaskStage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskStage (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskStage *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *isCommon;
@property (nullable, nonatomic, copy) NSNumber *isExpanded;
@property (nullable, nonatomic, copy) NSNumber *isSelected;
@property (nullable, nonatomic, copy) NSNumber *stageID;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) ProjectInfo *project;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectTask *> *tasks;

@end

@interface ProjectTaskStage (CoreDataGeneratedAccessors)

- (void)insertObject:(ProjectTask *)value inTasksAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTasksAtIndex:(NSUInteger)idx;
- (void)insertTasks:(NSArray<ProjectTask *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTasksAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTasksAtIndex:(NSUInteger)idx withObject:(ProjectTask *)value;
- (void)replaceTasksAtIndexes:(NSIndexSet *)indexes withTasks:(NSArray<ProjectTask *> *)values;
- (void)addTasksObject:(ProjectTask *)value;
- (void)removeTasksObject:(ProjectTask *)value;
- (void)addTasks:(NSOrderedSet<ProjectTask *> *)values;
- (void)removeTasks:(NSOrderedSet<ProjectTask *> *)values;

@end

NS_ASSUME_NONNULL_END
