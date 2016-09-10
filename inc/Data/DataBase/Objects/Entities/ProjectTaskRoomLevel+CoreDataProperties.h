//
//  ProjectTaskRoomLevel+CoreDataProperties.h
//  
//
//  Created by Nikolay Chaban on 9/11/16.
//
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ProjectTaskRoomLevel.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProjectTaskRoomLevel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSNumber *roomLevel;
@property (nullable, nonatomic, retain) NSNumber *level;
@property (nullable, nonatomic, retain) NSManagedObject *task;

@end

NS_ASSUME_NONNULL_END
