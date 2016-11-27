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

@dynamic startEndDate;
@dynamic factualStartEndDate;
@dynamic factualStartBeginDate;
@dynamic isCanceled;
@dynamic isDone;
@dynamic isExpired;
@dynamic startBeginDate;
@dynamic statuses;
@dynamic types;
@dynamic closeBeginDate;
@dynamic closeEndDate;
@dynamic factualCloseBeginDate;
@dynamic factualCloseEndDate;
@dynamic creatorsSelectedIndexes;
@dynamic responsiblesSelectedIndexes;
@dynamic approvementsSelectedIndexes;
@dynamic creators;
@dynamic project;
@dynamic responsibles;
@dynamic systems;
@dynamic workArea;
@dynamic approvementsAssignee;
@dynamic approvementsInvite;

@end
