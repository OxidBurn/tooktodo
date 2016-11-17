//
//  ProjectInfo+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 11/17/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OfflineSettings, ProjectCountry, ProjectRegion, ProjectRoleAssignments, ProjectRoles, ProjectSystem, ProjectTask, ProjectTaskRoomLevel, ProjectTaskStage, TeamMember;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectInfo : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectInfo+CoreDataProperties.h"
