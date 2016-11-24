//
//  ProjectTaskFilterContent+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "ProjectTaskFilterContent+CoreDataProperties.h"

@implementation ProjectTaskFilterContent (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskFilterContent *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskFilterContent"];
}

@dynamic statuses;
@dynamic types;
@dynamic endDate;
@dynamic startDate;
@dynamic factualStartDate;
@dynamic factualEndDate;
@dynamic isExpired;
@dynamic isDone;
@dynamic isCanceled;
@dynamic creators;
@dynamic responsibles;
@dynamic approvements;
@dynamic systems;
@dynamic workArea;

@end
