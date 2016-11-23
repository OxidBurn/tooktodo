//
//  TaskApprovments+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/22/16.
//
//

#import "TaskApprovments+CoreDataProperties.h"

@implementation TaskApprovments (CoreDataProperties)

+ (NSFetchRequest<TaskApprovments *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskApprovments"];
}

@dynamic createDate;
@dynamic approverUserId;
@dynamic task;

@end
