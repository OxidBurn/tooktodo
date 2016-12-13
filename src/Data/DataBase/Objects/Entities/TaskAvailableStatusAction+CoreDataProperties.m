//
//  TaskAvailableStatusAction+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "TaskAvailableStatusAction+CoreDataProperties.h"

@implementation TaskAvailableStatusAction (CoreDataProperties)

+ (NSFetchRequest<TaskAvailableStatusAction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskAvailableStatusAction"];
}

@dynamic statusActionID;
@dynamic stautsActionDescription;
@dynamic availableActionsList;

@end
