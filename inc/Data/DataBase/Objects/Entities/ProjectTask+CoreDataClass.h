//
//  ProjectTask+CoreDataClass.h
//  
//
//  Created by Lera on 23.11.16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectInfo, ProjectTaskMarker, ProjectTaskOwner, ProjectTaskResponsible, ProjectTaskRoleAssignments, ProjectTaskRoom, ProjectTaskRoomLevel, ProjectTaskStage, ProjectTaskWorkArea, TaskApprovments, TaskAvailableActionsList, TaskComment;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTask : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectTask+CoreDataProperties.h"
