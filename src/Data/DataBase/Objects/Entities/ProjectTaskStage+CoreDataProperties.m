//
//  ProjectTaskStage+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 9/16/16.
//
//

#import "ProjectTaskStage+CoreDataProperties.h"

@implementation ProjectTaskStage (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskStage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskStage"];
}

@dynamic isCommon;
@dynamic stageID;
@dynamic title;
@dynamic isExpanded;
@dynamic project;
@dynamic tasks;

@end
