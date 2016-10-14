//
//  TaskAvailableActionsList+CoreDataClass.h
//  
//
//  Created by Nikolay Chaban on 10/14/16.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ProjectTask, TaskAvailableAction, TaskAvailableStagesAction, TaskAvailableStatusAction;

NS_ASSUME_NONNULL_BEGIN

@interface TaskAvailableActionsList : NSManagedObject

@end

NS_ASSUME_NONNULL_END

#import "TaskAvailableActionsList+CoreDataProperties.h"
