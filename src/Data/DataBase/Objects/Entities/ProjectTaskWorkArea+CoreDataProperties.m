//
//  ProjectTaskWorkArea+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/22/16.
//
//

#import "ProjectTaskWorkArea+CoreDataProperties.h"

@implementation ProjectTaskWorkArea (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskWorkArea *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskWorkArea"];
}

@dynamic hasTasks;
@dynamic shortTitle;
@dynamic title;
@dynamic workAreaID;
@dynamic usedForFilters;
@dynamic task;

@end
