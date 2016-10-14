//
//  TaskAvailableStatusAction+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 10/14/16.
//
//

#import "TaskAvailableStatusAction+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskAvailableStatusAction (CoreDataProperties)

+ (NSFetchRequest<TaskAvailableStatusAction *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *statusActionID;
@property (nullable, nonatomic, copy) NSString *stautsActionDescription;
@property (nullable, nonatomic, retain) TaskAvailableActionsList *availableActionsList;

@end

NS_ASSUME_NONNULL_END
