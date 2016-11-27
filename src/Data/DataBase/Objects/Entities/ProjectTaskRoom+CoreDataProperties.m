//
//  ProjectTaskRoom+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/27/16.
//
//

#import "ProjectTaskRoom+CoreDataProperties.h"

@implementation ProjectTaskRoom (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoom *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskRoom"];
}

@dynamic isSelected;
@dynamic number;
@dynamic roomID;
@dynamic roomLevelId;
@dynamic tasksCount;
@dynamic tasksWithoutMarkers;
@dynamic title;
@dynamic mapContour;
@dynamic roomLevel;
@dynamic roomTask;
@dynamic task;
@dynamic taskFilterContent;

@end
