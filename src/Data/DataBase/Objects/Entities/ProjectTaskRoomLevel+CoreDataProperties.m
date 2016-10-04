//
//  ProjectTaskRoomLevel+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 10/4/16.
//
//

#import "ProjectTaskRoomLevel+CoreDataProperties.h"

@implementation ProjectTaskRoomLevel (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoomLevel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskRoomLevel"];
}

@dynamic level;
@dynamic roomLevel;
@dynamic task;
@dynamic rooms;
@dynamic map;
@dynamic project;

@end
