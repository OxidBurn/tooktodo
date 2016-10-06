//
//  ProjectTaskRoom+CoreDataProperties.m
//  
//
//  Created by Lera on 05.10.16.
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
@dynamic isSelected;
@dynamic mapContour;
@dynamic roomLevel;
@dynamic roomTask;
@dynamic task;

@end
