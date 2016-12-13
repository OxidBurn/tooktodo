//
//  ProjectTaskFilterContent+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 11/28/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSObject, ProjectInfo, ProjectInviteInfo, ProjectTaskAssignee, ProjectTaskRoom, ProjectTaskWorkArea;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskFilterContent : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectTaskFilterContent+CoreDataProperties.h"
