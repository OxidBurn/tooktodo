//
//  ProjectTaskRoom+CoreDataProperties.h
//  
//
//  Created by Lera on 05.10.16.
//
//

#import "ProjectTaskRoom+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoom (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoom *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *number;
@property (nullable, nonatomic, copy) NSNumber *roomID;
@property (nullable, nonatomic, copy) NSNumber *roomLevelId;
@property (nullable, nonatomic, copy) NSNumber *tasksCount;
@property (nullable, nonatomic, copy) NSNumber *tasksWithoutMarkers;
@property (nullable, nonatomic, copy) NSString *title;
@property (nullable, nonatomic, copy) NSNumber *isSelected;
@property (nullable, nonatomic, retain) ProjectTaskMapContour *mapContour;
@property (nullable, nonatomic, retain) ProjectTaskRoomLevel *roomLevel;
@property (nullable, nonatomic, retain) ProjectTask *roomTask;
@property (nullable, nonatomic, retain) ProjectTask *task;

@end

NS_ASSUME_NONNULL_END
