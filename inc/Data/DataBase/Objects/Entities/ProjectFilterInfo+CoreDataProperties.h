//
//  ProjectFilterInfo+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "ProjectFilterInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectFilterInfo (CoreDataProperties)

+ (NSFetchRequest<ProjectFilterInfo *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *statuses;
@property (nullable, nonatomic, retain) NSObject *creators;
@property (nullable, nonatomic, retain) NSObject *workAreas;
@property (nullable, nonatomic, retain) NSObject *responsibles;
@property (nullable, nonatomic, retain) NSObject *approves;
@property (nullable, nonatomic, retain) NSObject *types;
@property (nullable, nonatomic, copy) NSNumber *expired;
@property (nullable, nonatomic, retain) ProjectInfo *project;

@end

NS_ASSUME_NONNULL_END
