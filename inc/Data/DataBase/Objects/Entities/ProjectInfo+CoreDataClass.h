//
//  ProjectInfo+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 20.09.16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OfflineSettings, ProjectCountry, ProjectRegion, ProjectRoleAssignments, ProjectRoles, ProjectSystem, ProjectTask, ProjectTaskStage, TeamMember;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectInfo : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectInfo+CoreDataProperties.h"
