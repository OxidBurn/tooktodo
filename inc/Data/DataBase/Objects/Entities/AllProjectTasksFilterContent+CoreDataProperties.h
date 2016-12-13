//
//  AllProjectTasksFilterContent+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import "AllProjectTasksFilterContent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface AllProjectTasksFilterContent (CoreDataProperties)

+ (NSFetchRequest<AllProjectTasksFilterContent *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *closeBeginDate;
@property (nullable, nonatomic, copy) NSDate *closeEndDate;
@property (nullable, nonatomic, copy) NSDate *factualCloseBeginDate;
@property (nullable, nonatomic, copy) NSDate *factualCloseEndDate;
@property (nullable, nonatomic, copy) NSDate *factualStartBeginDate;
@property (nullable, nonatomic, copy) NSDate *factualStartEndDate;
@property (nullable, nonatomic, copy) NSNumber *isCanceled;
@property (nullable, nonatomic, copy) NSNumber *isDone;
@property (nullable, nonatomic, copy) NSNumber *isExpired;
@property (nullable, nonatomic, copy) NSNumber *rolesInProject;
@property (nullable, nonatomic, copy) NSDate *startBeginDate;
@property (nullable, nonatomic, copy) NSDate *startEndDate;
@property (nullable, nonatomic, retain) NSObject *statuses;
@property (nullable, nonatomic, retain) NSObject *types;
@property (nullable, nonatomic, retain) NSObject *projectSelectedIndexes;
@property (nullable, nonatomic, retain) NSOrderedSet<ProjectInfo *> *projects;

@end

@interface AllProjectTasksFilterContent (CoreDataGeneratedAccessors)

- (void)insertObject:(ProjectInfo *)value inProjectsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromProjectsAtIndex:(NSUInteger)idx;
- (void)insertProjects:(NSArray<ProjectInfo *> *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeProjectsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInProjectsAtIndex:(NSUInteger)idx withObject:(ProjectInfo *)value;
- (void)replaceProjectsAtIndexes:(NSIndexSet *)indexes withProjects:(NSArray<ProjectInfo *> *)values;
- (void)addProjectsObject:(ProjectInfo *)value;
- (void)removeProjectsObject:(ProjectInfo *)value;
- (void)addProjects:(NSOrderedSet<ProjectInfo *> *)values;
- (void)removeProjects:(NSOrderedSet<ProjectInfo *> *)values;

@end

NS_ASSUME_NONNULL_END
