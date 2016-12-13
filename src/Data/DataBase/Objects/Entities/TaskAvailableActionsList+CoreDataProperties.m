//
//  TaskAvailableActionsList+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 10/14/16.
//
//

#import "TaskAvailableActionsList+CoreDataProperties.h"

@implementation TaskAvailableActionsList (CoreDataProperties)

+ (NSFetchRequest<TaskAvailableActionsList *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskAvailableActionsList"];
}

@dynamic task;
@dynamic actions;
@dynamic statusActions;
@dynamic stages;

@end
