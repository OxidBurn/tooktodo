//
//  ProjectFilterInfo+CoreDataProperties.m
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import "ProjectFilterInfo+CoreDataProperties.h"

@implementation ProjectFilterInfo (CoreDataProperties)

+ (NSFetchRequest<ProjectFilterInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ProjectFilterInfo"];
}

@dynamic statuses;
@dynamic creators;
@dynamic workAreas;
@dynamic responsibles;
@dynamic approves;
@dynamic types;
@dynamic expired;
@dynamic project;

@end
