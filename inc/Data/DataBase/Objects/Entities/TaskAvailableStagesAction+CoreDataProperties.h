//
//  TaskAvailableStagesAction+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 10/14/16.
//
//

#import "TaskAvailableStagesAction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskAvailableStagesAction (CoreDataProperties)

+ (NSFetchRequest<TaskAvailableStagesAction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *stageActionID;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSNumber *isCommon;
@property (nullable, nonatomic, retain) TaskAvailableActionsList *availableActionsList;

@end

NS_ASSUME_NONNULL_END
