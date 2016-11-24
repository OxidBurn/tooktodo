//
//  ProjectTaskRoleAssignment+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 24.11.16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectInviteInfo, ProjectTaskAssignee, ProjectTaskRoleAssignments, ProjectTaskRoleType;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoleAssignment : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectTaskRoleAssignment+CoreDataProperties.h"
