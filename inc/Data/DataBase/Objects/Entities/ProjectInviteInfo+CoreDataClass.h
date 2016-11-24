//
//  ProjectInviteInfo+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 24.11.16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectRoleAssignments, ProjectRoleType, ProjectTaskResponsible, ProjectTaskRoleAssignment;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectInviteInfo : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectInviteInfo+CoreDataProperties.h"
