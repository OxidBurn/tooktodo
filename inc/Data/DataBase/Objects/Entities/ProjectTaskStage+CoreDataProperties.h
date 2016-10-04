//
//  ProjectTaskStage+CoreDataProperties.h
//  
//
//  Created by Lera on 30.09.16.
//
//

#import "ProjectTaskStage+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskStage (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskStage *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *isCommon;
@property (nullable, nonatomic, copy) NSNumber *isExpanded;
@property (nullable, nonatomic, copy) NSNumber *stageID;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSNumber *isSelected;
@property (nullable, nonatomic, retain) ProjectInfo *project;
@property (nullable, nonatomic, retain) NSSet<ProjectTask *> *tasks;

@end

@interface ProjectTaskStage (CoreDataGeneratedAccessors)

- (void)addTasksObject:(ProjectTask *)value;
- (void)removeTasksObject:(ProjectTask *)value;
- (void)addTasks:(NSSet<ProjectTask *> *)values;
- (void)removeTasks:(NSSet<ProjectTask *> *)values;

@end

NS_ASSUME_NONNULL_END
