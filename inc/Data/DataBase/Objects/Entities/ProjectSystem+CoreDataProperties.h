//
//  ProjectSystem+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "ProjectSystem+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectSystem (CoreDataProperties)

+ (NSFetchRequest<ProjectSystem *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *hasTasks;
@property (nullable, nonatomic, copy) NSNumber *isSelected;
@property (nullable, nonatomic, copy) NSString *shortTitle;
@property (nullable, nonatomic, copy) NSNumber *systemID;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, retain) ProjectInfo *project;
@property (nullable, nonatomic, retain) ProjectTaskFilterContent *taskFilterContent;

@end

NS_ASSUME_NONNULL_END
