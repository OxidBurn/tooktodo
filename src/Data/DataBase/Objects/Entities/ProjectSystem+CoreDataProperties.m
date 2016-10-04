//
//  ProjectSystem+CoreDataProperties.m
//  
//
//  Created by Lera on 30.09.16.
//
//

#import "ProjectSystem+CoreDataProperties.h"

@implementation ProjectSystem (CoreDataProperties)

+ (NSFetchRequest<ProjectSystem *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectSystem"];
}

@dynamic hasTasks;
@dynamic shortTitle;
@dynamic systemID;
@dynamic title;
@dynamic isSelected;
@dynamic project;

@end
