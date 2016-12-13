//
//  TaskAvailableAction+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 10/14/16.
//
//

#import "TaskAvailableAction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskAvailableAction (CoreDataProperties)

+ (NSFetchRequest<TaskAvailableAction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *actionID;
@property (nullable, nonatomic, copy) NSString *actionDescription;
@property (nullable, nonatomic, retain) TaskAvailableActionsList *availableActionsList;

@end

NS_ASSUME_NONNULL_END
