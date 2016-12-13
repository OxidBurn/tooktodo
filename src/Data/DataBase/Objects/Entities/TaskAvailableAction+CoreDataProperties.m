//
//  TaskAvailableAction+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 10/14/16.
//
//

#import "TaskAvailableAction+CoreDataProperties.h"

@implementation TaskAvailableAction (CoreDataProperties)

+ (NSFetchRequest<TaskAvailableAction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskAvailableAction"];
}

@dynamic actionID;
@dynamic actionDescription;
@dynamic availableActionsList;

@end
