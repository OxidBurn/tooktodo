//
//  TaskApprovments+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/22/16.
//
//

#import "TaskApprovments+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskApprovments (CoreDataProperties)

+ (NSFetchRequest<TaskApprovments *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *createDate;
@property (nullable, nonatomic, copy) NSNumber *approverUserId;
@property (nullable, nonatomic, retain) ProjectTask *task;

@end

NS_ASSUME_NONNULL_END
