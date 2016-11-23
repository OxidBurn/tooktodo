//
//  TaskLogDataContent+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/23/16.
//
//

#import "TaskLogDataContent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface TaskLogDataContent (CoreDataProperties)

+ (NSFetchRequest<TaskLogDataContent *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *commentId;
@property (nullable, nonatomic, copy) NSDate *oldStartDate;
@property (nullable, nonatomic, copy) NSDate *oldEndDate;
@property (nullable, nonatomic, copy) NSDate *newStartDate;
@property (nullable, nonatomic, copy) NSDate *newEndDate;
@property (nullable, nonatomic, copy) NSNumber *oldStatus;
@property (nullable, nonatomic, copy) NSNumber *newStatus;
@property (nullable, nonatomic, retain) NSObject *fileTitles;
@property (nullable, nonatomic, retain) NSObject *fileTitlesWithExtensions;
@property (nullable, nonatomic, retain) NSObject *storageFiles;
@property (nullable, nonatomic, copy) NSNumber *oldValue;
@property (nullable, nonatomic, copy) NSNumber *newValue;
@property (nullable, nonatomic, copy) NSNumber *userId;
@property (nullable, nonatomic, copy) NSNumber *projectRoleAssignmentId;
@property (nullable, nonatomic, copy) NSNumber *taskRoleType;
@property (nullable, nonatomic, copy) NSString *oldDescription;
@property (nullable, nonatomic, copy) NSString *newDescription;
@property (nullable, nonatomic, copy) NSNumber *oldWorkArea;
@property (nullable, nonatomic, copy) NSNumber *newWorkArea;
@property (nullable, nonatomic, retain) TaskLogInfo *taskLog;

@end

NS_ASSUME_NONNULL_END
