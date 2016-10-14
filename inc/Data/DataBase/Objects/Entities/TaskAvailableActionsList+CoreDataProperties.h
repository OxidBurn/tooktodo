//
//  TaskAvailableActionsList+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 10/14/16.
//
//

#import "TaskAvailableActionsList+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskAvailableActionsList (CoreDataProperties)

+ (NSFetchRequest<TaskAvailableActionsList *> *)fetchRequest;

@property (nullable, nonatomic, retain) ProjectTask *task;
@property (nullable, nonatomic, retain) NSSet<TaskAvailableAction *> *actions;
@property (nullable, nonatomic, retain) NSSet<TaskAvailableStatusAction *> *statusActions;
@property (nullable, nonatomic, retain) NSSet<TaskAvailableStagesAction *> *stages;

@end

@interface TaskAvailableActionsList (CoreDataGeneratedAccessors)

- (void)addActionsObject:(TaskAvailableAction *)value;
- (void)removeActionsObject:(TaskAvailableAction *)value;
- (void)addActions:(NSSet<TaskAvailableAction *> *)values;
- (void)removeActions:(NSSet<TaskAvailableAction *> *)values;

- (void)addStatusActionsObject:(TaskAvailableStatusAction *)value;
- (void)removeStatusActionsObject:(TaskAvailableStatusAction *)value;
- (void)addStatusActions:(NSSet<TaskAvailableStatusAction *> *)values;
- (void)removeStatusActions:(NSSet<TaskAvailableStatusAction *> *)values;

- (void)addStagesObject:(TaskAvailableStagesAction *)value;
- (void)removeStagesObject:(TaskAvailableStagesAction *)value;
- (void)addStages:(NSSet<TaskAvailableStagesAction *> *)values;
- (void)removeStages:(NSSet<TaskAvailableStagesAction *> *)values;

@end

NS_ASSUME_NONNULL_END
