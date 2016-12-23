//
//  TaskLogInfo+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 12/23/16.
//
//

#import "TaskLogInfo+CoreDataProperties.h"

@implementation TaskLogInfo (CoreDataProperties)

+ (NSFetchRequest<TaskLogInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskLogInfo"];
}

@dynamic createdDate;
@dynamic projectRoleTypeDescription;
@dynamic text;
@dynamic userAvatar;
@dynamic userFullName;
@dynamic logType;
@dynamic data;
@dynamic task;

@end
