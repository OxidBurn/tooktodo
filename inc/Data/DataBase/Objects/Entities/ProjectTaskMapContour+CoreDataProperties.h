//
//  ProjectTaskMapContour+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 10/4/16.
//
//

#import "ProjectTaskMapContour+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskMapContour (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskMapContour *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *geoJson;
@property (nullable, nonatomic, copy) NSNumber *mapContourID;
@property (nullable, nonatomic, copy) NSString *previewImage;
@property (nullable, nonatomic, copy) NSNumber *roomId;
@property (nullable, nonatomic, retain) ProjectTaskRoom *room;
@property (nullable, nonatomic, retain) ProjectTaskRoomLevel *roomLevel;
@property (nullable, nonatomic, retain) RoomLevelMap *map;

@end

NS_ASSUME_NONNULL_END
