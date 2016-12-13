//
//  AllProjectTasksFilterContent+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import "AllProjectTasksFilterContent+CoreDataProperties.h"

@implementation AllProjectTasksFilterContent (CoreDataProperties)

+ (NSFetchRequest<AllProjectTasksFilterContent *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"AllProjectTasksFilterContent"];
}

@dynamic closeBeginDate;
@dynamic closeEndDate;
@dynamic factualCloseBeginDate;
@dynamic factualCloseEndDate;
@dynamic factualStartBeginDate;
@dynamic factualStartEndDate;
@dynamic isCanceled;
@dynamic isDone;
@dynamic isExpired;
@dynamic rolesInProject;
@dynamic startBeginDate;
@dynamic startEndDate;
@dynamic statuses;
@dynamic types;
@dynamic projectSelectedIndexes;
@dynamic projects;

@end
