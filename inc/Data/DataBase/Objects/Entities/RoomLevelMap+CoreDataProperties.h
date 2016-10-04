//
//  RoomLevelMap+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 10/4/16.
//
//

#import "RoomLevelMap+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface RoomLevelMap (CoreDataProperties)

+ (NSFetchRequest<RoomLevelMap *> *)fetchRequest;

@property (nullable, nonatomic, retain) NSObject *marker;
@property (nullable, nonatomic, copy) NSNumber *hasMarkers;
@property (nullable, nonatomic, copy) NSNumber *mapId;
@property (nullable, nonatomic, copy) NSString *originalImage;
@property (nullable, nonatomic, copy) NSNumber *originalImageWidth;
@property (nullable, nonatomic, copy) NSNumber *originalImageHeight;
@property (nullable, nonatomic, copy) NSString *previewImage;
@property (nullable, nonatomic, retain) NSSet<ProjectTaskMapContour *> *mapContour;

@end

@interface RoomLevelMap (CoreDataGeneratedAccessors)

- (void)addMapContourObject:(ProjectTaskMapContour *)value;
- (void)removeMapContourObject:(ProjectTaskMapContour *)value;
- (void)addMapContour:(NSSet<ProjectTaskMapContour *> *)values;
- (void)removeMapContour:(NSSet<ProjectTaskMapContour *> *)values;

@end

NS_ASSUME_NONNULL_END
