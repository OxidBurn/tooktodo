//
//  TaskLogInfo+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/23/16.
//
//

#import "TaskLogInfo+CoreDataProperties.h"

@implementation TaskLogInfo (CoreDataProperties)

+ (NSFetchRequest<TaskLogInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskLogInfo"];
}

@dynamic createdDate;
@dynamic userFullName;
@dynamic userAvatar;
@dynamic projectRoleTypeDescription;
@dynamic text;
@dynamic task;
@dynamic data;

@end
