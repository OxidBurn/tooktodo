//
//  ProjectTaskMapContour+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 10/4/16.
//
//

#import "ProjectTaskMapContour+CoreDataProperties.h"

@implementation ProjectTaskMapContour (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskMapContour *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskMapContour"];
}

@dynamic geoJson;
@dynamic mapContourID;
@dynamic previewImage;
@dynamic roomId;
@dynamic room;
@dynamic roomLevel;
@dynamic map;

@end
