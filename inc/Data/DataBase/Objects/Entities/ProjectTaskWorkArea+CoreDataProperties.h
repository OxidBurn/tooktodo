//
//  ProjectTaskWorkArea+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/22/16.
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
@property (nullable, nonatomic, copy) NSNumber *usedForFilters;
@property (nullable, nonatomic, retain) ProjectTask *task;

@end

NS_ASSUME_NONNULL_END
