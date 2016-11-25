//
//  ProjectTaskFilterContent+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 11/25/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class NSObject, ProjectInfo, ProjectSystem, ProjectTaskAssignee, ProjectTaskWorkArea;

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskFilterContent : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "ProjectTaskFilterContent+CoreDataProperties.h"
