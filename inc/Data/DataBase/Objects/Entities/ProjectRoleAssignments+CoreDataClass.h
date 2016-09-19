//
//  ProjectRoleAssignments+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 9/19/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectInfo, ProjectInviteInfo, ProjectRoleType, ProjectTaskAssignee;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectRoleAssignments : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectRoleAssignments+CoreDataProperties.h"
