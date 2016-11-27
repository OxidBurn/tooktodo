//
//  ProjectTaskWorkArea+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import "ProjectTaskWorkArea+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskWorkArea (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskWorkArea *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *hasTasks;
@property (nullable, nonatomic, copy) NSString *shortTitle;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSNumber *workAreaID;
@property (nullable, nonatomic, retain) ProjectTask *task;
@property (nullable, nonatomic, retain) ProjectTaskFilterContent *taskFilterContent;

@end

NS_ASSUME_NONNULL_END
