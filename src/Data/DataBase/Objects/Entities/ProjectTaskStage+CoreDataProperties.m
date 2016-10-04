//
//  ProjectTaskStage+CoreDataProperties.m
//  
//
//  Created by Lera on 30.09.16.
//
//

#import "ProjectTaskStage+CoreDataProperties.h"

@implementation ProjectTaskStage (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskStage *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskStage"];
}

@dynamic isCommon;
@dynamic isExpanded;
@dynamic stageID;
@dynamic title;
@dynamic isSelected;
@dynamic project;
@dynamic tasks;

@end
