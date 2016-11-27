//
//  ProjectTaskFilterContent+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import "ProjectTaskFilterContent+CoreDataProperties.h"

@implementation ProjectTaskFilterContent (CoreDataProperties)

+ (NSFetchRequest<ProjectTaskFilterContent *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectTaskFilterContent"];
}

@dynamic approvementsSelectedIndexes;
@dynamic closeBeginDate;
@dynamic closeEndDate;
@dynamic creatorsSelectedIndexes;
@dynamic factualCloseBeginDate;
@dynamic factualCloseEndDate;
@dynamic factualStartBeginDate;
@dynamic factualStartEndDate;
@dynamic isCanceled;
@dynamic isDone;
@dynamic isExpired;
@dynamic responsiblesSelectedIndexes;
@dynamic startBeginDate;
@dynamic startEndDate;
@dynamic statuses;
@dynamic types;
@dynamic roomsSelectedIndexes;
@dynamic workAreasSelectedIndexes;
@dynamic approvementsAssignee;
@dynamic approvementsInvite;
@dynamic creators;
@dynamic project;
@dynamic responsibles;
@dynamic workAreas;
@dynamic rooms;

@end
