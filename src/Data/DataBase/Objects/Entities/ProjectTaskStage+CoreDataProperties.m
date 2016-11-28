//
//  ProjectTaskStage+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import "ProjectTaskStage+CoreDataProperties.h"

@implementation ProjectTaskStage (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskStage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskStage"];
}

@dynamic isCommon;
@dynamic isExpanded;
@dynamic isSelected;
@dynamic stageID;
@dynamic title;
@dynamic project;
@dynamic tasks;

@end
