//
//  TaskComment+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/16/16.
//
//

#import "TaskComment+CoreDataProperties.h"

@implementation TaskComment (CoreDataProperties)

+ (NSFetchRequest<TaskComment *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"TaskComment"];
}

@dynamic commentID;
@dynamic message;
@dynamic author;
@dynamic avatarSrc;
@dynamic authorId;
@dynamic date;
@dynamic task;
@dynamic storageFiles;

@end
