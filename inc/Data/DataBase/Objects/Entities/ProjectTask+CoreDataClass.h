//
//  ProjectTask+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 10/14/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectInfo, ProjectTaskMarker, ProjectTaskOwner, ProjectTaskResponsible, ProjectTaskRoleAssignments, ProjectTaskRoom, ProjectTaskRoomLevel, ProjectTaskStage, ProjectTaskWorkArea, TaskAvailableActionsList;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTask : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectTask+CoreDataProperties.h"
