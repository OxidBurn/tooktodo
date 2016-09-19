//
//  ProjectTaskResponsible+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 9/18/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectTask, ProjectTaskAssignee, ProjectTaskRoleType;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskResponsible : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectTaskResponsible+CoreDataProperties.h"