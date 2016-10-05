//
//  ProjectTaskRoomLevel+CoreDataProperties.m
//  
//
//  Created by Lera on 05.10.16.
//
//

#import "ProjectTaskRoomLevel+CoreDataProperties.h"

@implementation ProjectTaskRoomLevel (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoomLevel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskRoomLevel"];
}

@dynamic level;
@dynamic roomLevel;
@dynamic isExpanded;
@dynamic map;
@dynamic project;
@dynamic rooms;
@dynamic task;

@end
