//
//  ProjectTaskFilterContent+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "ProjectTaskFilterContent+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskFilterContent (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskFilterContent *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *statuses;
@property (nullable, nonatomic, retain) NSObject *types;
@property (nullable, nonatomic, copy) NSDate *endDate;
@property (nullable, nonatomic, copy) NSDate *startDate;
@property (nullable, nonatomic, copy) NSDate *factualStartDate;
@property (nullable, nonatomic, copy) NSDate *factualEndDate;
@property (nullable, nonatomic, copy) NSNumber *isExpired;
@property (nullable, nonatomic, copy) NSNumber *isDone;
@property (nullable, nonatomic, copy) NSNumber *isCanceled;
@property (nullable, nonatomic, retain) ProjectTaskAssignee *creators;
@property (nullable, nonatomic, retain) ProjectTaskAssignee *responsibles;
@property (nullable, nonatomic, retain) ProjectTaskAssignee *approvements;
@property (nullable, nonatomic, retain) ProjectSystem *systems;
@property (nullable, nonatomic, retain) ProjectTaskWorkArea *workArea;

@end

NS_ASSUME_NONNULL_END
