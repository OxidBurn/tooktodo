//
//  ProjectTaskRoomLevel+CoreDataProperties.h
//  
//
//  Created by Lera on 05.10.16.
//
//

#import "ProjectTaskRoomLevel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoomLevel (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoomLevel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSNumber *level;
@property (nullable, nonatomic, copy) NSNumber *roomLevel;
@property (nullable, nonatomic, copy) NSNumber *isExpanded;
@property (nullable, nonatomic, retain) ProjectTaskMapContour *map;
@property (nullable, nonatomic, retain) ProjectInfo *project;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskRoom *> *rooms;
@property (nullable, nonatomic, retain) ProjectTask *task;

@end

@interface ProjectTaskRoomLevel (CoreDataGeneratedAccessors)

- (void)addRoomsObject:(ProjectTaskRoom *)value;
- (void)removeRoomsObject:(ProjectTaskRoom *)value;
- (void)addRooms:(NSSet<ProjectTaskRoom *> *)values;
- (void)removeRooms:(NSSet<ProjectTaskRoom *> *)values;

@end

NS_ASSUME_NONNULL_END
