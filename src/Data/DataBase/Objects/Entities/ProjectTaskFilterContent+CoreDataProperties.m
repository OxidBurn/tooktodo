//
//  ProjectTaskFilterContent+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/27/16.
//
//

#import "ProjectTaskFilterContent+CoreDataProperties.h"

@implementation ProjectTaskFilterContent (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskFilterContent *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskFilterContent"];
}

@dynamic endDate;
@dynamic factualEndDate;
@dynamic factualStartDate;
@dynamic isCanceled;
@dynamic isDone;
@dynamic isExpired;
@dynamic startDate;
@dynamic statuses;
@dynamic types;
@dynamic creators;
@dynamic project;
@dynamic responsibles;
@dynamic systems;
@dynamic workArea;
@dynamic approvementsAssignee;
@dynamic approvementsInvite;

@end
