//
//  ProjectTaskRoom+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 9/18/16.
//
//

#import "ProjectTaskRoom+CoreDataProperties.h"

@implementation ProjectTaskRoom (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoom *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskRoom"];
}

@dynamic number;
@dynamic roomID;
@dynamic roomLevelId;
@dynamic tasksCount;
@dynamic tasksWithoutMarkers;
@dynamic title;
@dynamic mapContour;
@dynamic task;
@dynamic roomTask;

@end
