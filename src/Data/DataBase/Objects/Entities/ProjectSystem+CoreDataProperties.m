//
//  ProjectSystem+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "ProjectSystem+CoreDataProperties.h"

@implementation ProjectSystem (CoreDataProperties)

+ (NSFetchRequest<ProjectSystem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectSystem"];
}

@dynamic hasTasks;
@dynamic isSelected;
@dynamic shortTitle;
@dynamic systemID;
@dynamic title;
@dynamic project;
@dynamic taskFilterContent;

@end
