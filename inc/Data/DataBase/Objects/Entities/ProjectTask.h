//
//  ProjectTask.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectInfo, ProjectTaskMarker, ProjectTaskOwner, ProjectTaskResponsible, ProjectTaskRoleAssignments, ProjectTaskRoom, ProjectTaskRoomLevel, ProjectTaskStage, ProjectTaskSubTasks, ProjectTaskWorkArea;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTask : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "ProjectTask+CoreDataProperties.h"
