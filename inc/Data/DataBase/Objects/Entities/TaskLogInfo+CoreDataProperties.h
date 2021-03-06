//
//  TaskLogInfo+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/23/16.
//
//

#import "TaskLogInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskLogInfo (CoreDataProperties)

+ (NSFetchRequest<TaskLogInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *createdDate;
@property (nullable, nonatomic, copy) NSString *userFullName;
@property (nullable, nonatomic, copy) NSString *userAvatar;
@property (nullable, nonatomic, copy) NSString *projectRoleTypeDescription;
@property (nullable, nonatomic, copy) NSString *text;
@property (nullable, nonatomic, retain) ProjectTask *task;
@property (nullable, nonatomic, retain) TaskLogDataContent *data;

@end

NS_ASSUME_NONNULL_END
