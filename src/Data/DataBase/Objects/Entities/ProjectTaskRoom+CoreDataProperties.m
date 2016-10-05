//
//  ProjectTaskRoom+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 10/4/16.
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
@dynamic roomTask;
@dynamic task;
@dynamic roomLevel;

@end
