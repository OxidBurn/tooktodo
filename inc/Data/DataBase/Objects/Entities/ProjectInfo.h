//
//  ProjectInfo.h
//  
//
//  Created by Глеб on 09.09.16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class OfflineSettings, ProjectCountry, ProjectRegion, ProjectRoles, ProjectSystem, TeamMember;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectInfo : NSManagedObject

// Insert code here to declare functionality of your managed object subclass

@end

NS_ASSUME_NONNULL_END

#import "ProjectInfo+CoreDataProperties.h"
