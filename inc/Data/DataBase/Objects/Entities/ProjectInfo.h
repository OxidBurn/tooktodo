//
//  ProjectInfo.h
//  
//
//  Created by Nikolay Chaban on 9/13/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OfflineSettings, ProjectCountry, ProjectRegion, ProjectRoles, ProjectSystem, ProjectTask, ProjectTaskStage, TeamMember;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectInfo : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "ProjectInfo+CoreDataProperties.h"
