//
//  ProjectTaskResponsible+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 11/24/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectInviteInfo, ProjectTask, ProjectTaskAssignee, ProjectTaskRoleType;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskResponsible : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectTaskResponsible+CoreDataProperties.h"
