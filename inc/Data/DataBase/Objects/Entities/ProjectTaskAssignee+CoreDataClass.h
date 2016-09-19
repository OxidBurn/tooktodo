//
//  ProjectTaskAssignee+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 9/19/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectRoleAssignments, ProjectRoles, ProjectTaskResponsible, ProjectTaskRoleAssignment;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskAssignee : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectTaskAssignee+CoreDataProperties.h"
