//
//  TaskAvailableStagesAction+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 10/14/16.
//
//

#import "TaskAvailableStagesAction+CoreDataProperties.h"

@implementation TaskAvailableStagesAction (CoreDataProperties)

+ (NSFetchRequest<TaskAvailableStagesAction *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskAvailableStagesAction"];
}

@dynamic stageActionID;
@dynamic title;
@dynamic isCommon;
@dynamic availableActionsList;

@end
