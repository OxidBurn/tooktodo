//
//  ProjectTaskRoomLevel+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 10/7/16.
//
//

#import "ProjectTaskRoomLevel+CoreDataProperties.h"

@implementation ProjectTaskRoomLevel (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskRoomLevel *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskRoomLevel"];
}

@dynamic isExpanded;
@dynamic isSelected;
@dynamic level;
@dynamic roomLevelID;
@dynamic map;
@dynamic project;
@dynamic rooms;
@dynamic task;

@end
