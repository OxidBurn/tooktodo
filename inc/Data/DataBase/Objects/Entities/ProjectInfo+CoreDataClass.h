//
//  ProjectInfo+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 11/25/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OfflineSettings, ProjectCountry, ProjectFilterInfo, ProjectRegion, ProjectRoleAssignments, ProjectRoles, ProjectSystem, ProjectTask, ProjectTaskFilterContent, ProjectTaskRoomLevel, ProjectTaskStage, TeamMember;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectInfo : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectInfo+CoreDataProperties.h"
