//
//  RoomLevelMap+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 10/4/16.
//
//

#import "RoomLevelMap+CoreDataProperties.h"

@implementation RoomLevelMap (CoreDataProperties)

+ (NSFetchRequest<RoomLevelMap *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"RoomLevelMap"];
}

@dynamic marker;
@dynamic hasMarkers;
@dynamic mapId;
@dynamic originalImage;
@dynamic originalImageWidth;
@dynamic originalImageHeight;
@dynamic previewImage;
@dynamic mapContour;

@end
